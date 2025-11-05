//
//  RatingCategory.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//
import SwiftUI

public enum RatingCategory {
    case low, medium, high

    init(rating: Double) {
        switch rating {
        case ..<3: self = .low
        case 3..<4: self = .medium
        default: self = .high
        }
    }

    var iconName: String {
        switch self {
        case .low: return "hand.thumbsdown.fill"
        case .medium: return "hand.thumbsup"
        case .high: return "hand.thumbsup.fill"
        }
    }

    var color: Color {
        switch self {
        case .low: return .red
        case .medium: return .orange
        case .high: return .green
        }
    }
}
