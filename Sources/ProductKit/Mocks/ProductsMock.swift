//
//  ProductsMock.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//
import Foundation

public extension Product {
    static var mock: Self {
        Product(
            id: Int.random(in: 0...100000),
            title: "Sample Product",
            description: "This is a sample product used for previews",
            category: "Smartphones",
            price: 299.99,
            discountPercentage: 10,
            rating: 4.5,
            stock: 20,
            tags: ["Electronics", "Phone", "Mobile"],
            brand: "Sample Brand",
            sku: "SAMPLE123",
            weight: 200,
            dimensions: .init(width: 10, height: 15, depth: 1),
            warrantyInformation: "2-year warranty",
            shippingInformation: "Ships worldwide",
            availabilityStatus: "In Stock",
            reviews: [],
            returnPolicy: "30-day return",
            minimumOrderQuantity: 1,
            meta: .init(
                createdAt: "2025-01-01",
                updatedAt: "2025-01-02",
                barcode: "123456789",
                qrCode: URL(string: "https://dummyjson.com/data/products/1/1.jpg")!
            ),
            thumbnail: URL(string: "https://i.dummyjson.com/data/products/1/1.jpg"),
            images: [
                URL(string: "https://i.dummyjson.com/data/products/1/1.jpg")!,
                URL(string: "https://i.dummyjson.com/data/products/1/2.jpg")!,
                URL(string: "https://i.dummyjson.com/data/products/1/3.jpg")!
            ]
        )
    }
}
