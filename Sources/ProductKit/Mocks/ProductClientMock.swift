//
//  ProductClientMock.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Combine

public struct ProductDomainMock: ProductDomain {
  
    public init() {}

    public let products: [Product] = [.mock, .mock, .mock, .mock]

    
    public func searchProduct(key: String) -> AnyPublisher<[Product], Never> {
        let response = products
        return Just(response)
                .eraseToAnyPublisher()
    }
    
    public func products(request: ProductRequest) -> AnyPublisher<ProductsPagination, any Error> {
        let response = ProductsPagination(products: products, total: products.count)
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func product(by id: Int) -> AnyPublisher<Product, Error> {
        guard let product = products.first(where: { $0.id == id }) else {
            return Fail(error: NetworkError.keyNotFound)
                .eraseToAnyPublisher()
        }
        return Just(product)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

public enum NetworkError: Error {
    case keyNotFound
}
