//
//  Meta.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation

public struct Meta: Codable {
    public var createdAt: String
    public var updatedAt: String
    public var barcode: String
    public var qrCode: URL
}
