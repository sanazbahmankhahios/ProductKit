//
//  Review.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation

public struct Review: Codable {
    public let rating: Int
    public let comment: String
    public var date: String
    public var reviewerName: String
    public var reviewerEmail: String
}
