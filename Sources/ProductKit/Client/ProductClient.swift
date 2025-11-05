//
//  ProductClient.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation
import Combine

public protocol ProductClient {
    func products(request: ProductRequest) -> AnyPublisher<ProductResponse, Error>
    func product(by id: Int) -> AnyPublisher<Product, Error>
}

public struct ProductClientDependency {
    public var client: ProductClient

    public init(client: ProductClient) {
        self.client = client
    }

    public func products(request: ProductRequest) -> AnyPublisher<ProductResponse, Error> {
        client.products(request: request)
    }

    public func product(by id: Int) -> AnyPublisher<Product, Error> {
        client.product(by: id)
    }
}
