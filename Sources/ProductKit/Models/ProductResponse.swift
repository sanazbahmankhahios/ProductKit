//
//  ProductResponse.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation

public struct ProductResponse: Decodable {
    public var products: [Product]
    public var total: Int
}
