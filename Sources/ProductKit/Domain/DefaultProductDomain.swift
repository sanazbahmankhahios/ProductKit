//
//  DefaultProductDomain.swift
//  ProductKit
//
//  Created by sanaz on 11/7/25.
//

import Foundation
import Combine

public final class DefaultProductDomain: ProductDomain {
  
    let cache: CacheLayer
    
    public init(cache: CacheLayer) {
        self.cache = cache
    }
    
    public func product(by id: Int) -> AnyPublisher<Product, Error> {
        RequestHandler.shared.call(ProductEndpoint.product(id))
            .tryMap { (product: Product) in
                if product.stock <= 0 {
                    throw ProductClientError.outOfStack
                }
                return product
            }
            .catch { error -> AnyPublisher<Product, Error> in
                Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func searchProduct(key: String) -> AnyPublisher<[Product], Never> {
        
        return Future<[Product], Never> { [weak self] promise in
            guard let self = self else {
                promise(.success([]))
                return
            }
            let cached : [Product] = self.cache.load() ?? []
            let trimmed = key.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else {
                promise(.success(cached))
                return
            }
            
            let filtered = cached.filter { self.matches(product: $0, text: trimmed) }
            promise(.success(filtered))
        }
        .eraseToAnyPublisher()
    }
    
    private func matches(product: Product, text: String) -> Bool {
        let normalizedQuery = text
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
        let queryWords = normalizedQuery.split(separator: " ")
        
        let searchableText = (product.title + " " + product.description)
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
        
        return queryWords.allSatisfy { searchableText.contains($0) }
    }
    
    public func products(request: ProductRequest) -> AnyPublisher<ProductsPagination, Error> {
        let cached: [Product]? = cache.load()
        
        let cachedPublisher = Just(ProductsPagination(products: cached ?? [], total: cached?.count ??  0))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let networkPublisher = RequestHandler.shared
            .call(ProductEndpoint.products(request))
            .map {[weak self] (response: ProductResponse) -> ProductsPagination in
                self?.cache.save(value: response.products)
                return ProductsPagination(products: response.products, total: response.total)
            }
            .catch { error -> AnyPublisher<ProductsPagination, Error> in
                Just(ProductsPagination(products: cached ?? [], total: cached?.count ??  0))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return cachedPublisher
            .append(networkPublisher)
            .eraseToAnyPublisher()
    }
    
}

enum ProductClientError: LocalizedError {
    case outOfStack
}
