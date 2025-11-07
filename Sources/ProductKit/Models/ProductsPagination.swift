//
//  ProductsPagination.swift
//  ProductKit
//
//  Created by sanaz on 11/7/25.
//
import Foundation

public struct ProductsPagination: Decodable {
    public var products: [Product]
    public var total: Int
}
