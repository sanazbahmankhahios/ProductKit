//
//  ProductClient.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation
import Combine

public protocol ProductDomain {
    func searchProduct(key: String) -> AnyPublisher<[Product], Never>
    func products(request: ProductRequest) -> AnyPublisher<ProductsPagination, Error>
    func product(by id: Int) -> AnyPublisher<Product, Error>
}
