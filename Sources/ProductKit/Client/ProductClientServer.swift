//
//  ProductClientServer.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//
import Combine

public struct ProductClientServer: ProductClient {
    private let requestHandler: RequestHandler

    public init(requestHandler: RequestHandler = RequestHandlerFactory.makeHandler()) {
        self.requestHandler = requestHandler
    }

    public func products(request: ProductRequest) -> AnyPublisher<ProductResponse, Error> {
        requestHandler.call(ProductEndpoint.products(request))
    }

    public func product(by id: Int) -> AnyPublisher<Product, Error> {
        requestHandler.call(ProductEndpoint.product(id))
    }
}

