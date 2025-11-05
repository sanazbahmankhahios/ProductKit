//
//  ProductEndpoint.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation

public enum ProductEndpoint {
    case products(ProductRequest)
    case product(Int)
}

extension ProductEndpoint: Endpoint {
    public var path: String {
        switch self {
        case .products:
            "/products"
        case .product(let id):
            "/products/\(id)"
        }
    }

    public var parameters: RequestParameters? {
        switch self {
        case let .products(request):
            return .queryParameter(request, encoder: JSONEncoder())
        default:
            return nil
        }
    }
}
