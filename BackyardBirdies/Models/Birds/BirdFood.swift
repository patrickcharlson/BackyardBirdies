//
//  BirdFood.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 20/07/2025.
//

import SwiftData
import SwiftUI

@Model public class BirdFood {
    @Attribute(.unique) public var id: String
    public var name: String
    public var summary: String
    public var products: [Product]
    public var priority: Int
    public var ownedQuantity: Int
    
    public var isPremium: Bool {
        !products.isEmpty
    }
    
    public var orderedProducts: [Product] {
        products.sorted { lhs, rhs in
            lhs.quantity > rhs.quantity
        }
    }
    
    public init(
        id: String,
        name: String,
        summary: String,
        products: [Product] = [],
        priority: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.products = products
        self.ownedQuantity = 0
        self.priority = priority ?? (products.isEmpty ? 0 : 1)
    }
    
    public struct Product: Identifiable, Codable {
        public var id: String
        public var quantity: Int
    }
}

extension BirdFood {
    public var image: Image {
        Image("Bird Food/\(id)")
            .resizable()
    }
    
    public var alternateImage: Image {
        Image("Bird Food/Shop Alternates/\(id)")
            .resizable()
    }
}
