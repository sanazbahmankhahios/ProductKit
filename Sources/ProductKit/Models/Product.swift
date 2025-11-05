//
//  Product.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation

public struct Product: Decodable, Identifiable {
    public let id: Int
    public let title: String
    public let description: String
    public let category: String
    public let price: Double
    public let discountPercentage: Double
    public let rating: Double
    public let stock: Int
    public let tags: [String]
    public let brand: String?
    public let sku: String
    public let weight: Int
    public let dimensions: Dimensions
    public let warrantyInformation: String
    public let shippingInformation: String
    public let availabilityStatus: String
    public let reviews: [Review]
    public let returnPolicy: String
    public let minimumOrderQuantity: Int
    public let meta: Meta
    public let thumbnail: URL?
    public let images: [URL]
}
