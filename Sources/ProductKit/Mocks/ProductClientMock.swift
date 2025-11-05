//
//  ProductClientMock.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Combine

public struct ProductClientMock: ProductClient {
    public init() {}

    public let products: [Product] = [.mock, .mock, .mock, .mock]

    public func products(request: ProductRequest) -> AnyPublisher<ProductResponse, Error> {
        let response = ProductResponse(products: products, total: products.count)
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
