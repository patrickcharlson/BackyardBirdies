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
}
