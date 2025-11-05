//
//  Double+Extensions.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//
import Foundation

public extension Double {
    var currencyValue: String {
        self.formatted(.currency(code: "EUR"))
    }
}
