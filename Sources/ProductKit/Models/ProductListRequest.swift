//
//  ProductListRequest.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation

public struct ProductRequest: Encodable {
    public var limit: Int
    public var skip: Int

    public init(limit: Int, skip: Int) {
        self.limit = limit
        self.skip = skip
    }
}
