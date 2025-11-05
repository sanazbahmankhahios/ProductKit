//
//  ProductClientServer.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//
import Combine
import Foundation

public struct ProductClientServer: ProductClient {
    private let requestHandler: RequestHandler

    public init(requestHandler: RequestHandler = RequestHandlerFactory.makeHandler()) {
        self.requestHandler = requestHandler
    }

    public func products(request: ProductRequest) -> AnyPublisher<ProductResponse, Error> {
        requestHandler.call(ProductEndpoint.products(request))
            .catch { error -> AnyPublisher<ProductResponse, Error> in
                Just(ProductResponse(products: [], total: 0))
                                .setFailureType(to: Error.self)
                                .eraseToAnyPublisher()
                        }
                        .eraseToAnyPublisher()
    }

    public func product(by id: Int) -> AnyPublisher<Product, Error> {
        requestHandler.call(ProductEndpoint.product(id))
            .tryMap { (product: Product) in
                if product.stock <= 0 {
                    throw NSError(
                        domain: "ProductClientServer",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: "Out of stock"]
                    )
                }
                return product
            }
            .catch { error -> AnyPublisher<Product, Error> in
                Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

