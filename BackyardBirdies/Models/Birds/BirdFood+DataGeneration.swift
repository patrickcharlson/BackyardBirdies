//
//  BirdFood+DataGeneration.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 20/07/2025.
//

import SwiftData
import OSLog

private let logger = Logger(subsystem: "Backyard Birds Data", category: "BirdFood")

 extension BirdFood {
     static func generateAll(modelContext: ModelContext) {
         logger.info("Generating all Bird Food...")
         
         modelContext.insert(BirdFood(
            id: "Nutrition Pellet",
            name: String(localized: "Nutrition Pellet", table: "BirdFood"),
            summary: String(localized: "A nutritious snack that any bird loves.", table: "BirdFood"),
            products: [
                Product(
                    id: "pellet.single",
                    quantity: 1
                ),
                Product(
                    id: "pellet.box",
                    quantity: 5
                )
            ],
            priority: 3
         ))
         
         logger.info("Nectar")
         modelContext.insert(BirdFood(
             id: "Nectar",
             name: String(localized: "Nectar", table: "BirdFood"),
             summary: String(localized: "A sweet nectar to draw birds to your backyard.", table: "BirdFood"),
             products: [
                 Product(
                     id: "nectar.cup",
                     quantity: 1
                 ),
                 Product(
                     id: "nectar.bottle",
                     quantity: 5
                 )
             ],
             priority: 2
         ))
         
         logger.info("Golden Acorn")
         modelContext.insert(BirdFood(
             id: "Golden Acorn",
             name: String(localized: "Golden Acorn", table: "BirdFood"),
             summary: String(localized: "Birds crave this golden treat.", table: "BirdFood"),
             products: [
                 Product(
                     id: "acorns.individual",
                     quantity: 1
                 ),
                 Product(
                     id: "acorns.collection",
                     quantity: 5
                 )
             ]
         ))
         
         logger.info("Sunflower seeds")
         modelContext.insert(BirdFood(
             id: "Sunflower Seeds",
             name: String(localized: "Sunflower Seeds", table: "BirdFood"),
             summary: String(localized: "A favorite for many backyard visitors.", table: "BirdFood")
         ))
         
         modelContext.insert(BirdFood(
             id: "Corn",
             name: String(localized: "Corn", table: "BirdFood"),
             summary: String(localized: "Sweet treats for our feathered friends.", table: "BirdFood")
         ))
         
         modelContext.insert(BirdFood(
             id: "Millet Seeds",
             name: String(localized: "Millet Seeds", table: "BirdFood"),
             summary: String(localized: "Fun fall flavor in every bite.", table: "BirdFood")
         ))
         
         modelContext.insert(BirdFood(
             id: "Peanuts",
             name: String(localized: "Peanuts", table: "BirdFood"),
             summary: String(localized: "Deshelled peanuts, buttery smooth taste!", table: "BirdFood")
         ))
         
         modelContext.insert(BirdFood(
             id: "Safflower Seeds",
             name: String(localized: "Safflower Seeds", table: "BirdFood"),
             summary: String(localized: "The bitter rival of sunflower seeds.", table: "BirdFood")
         ))
         
         modelContext.insert(BirdFood(
             id: "Sorghum Seeds",
             name: String(localized: "Sorghum Seeds", table: "BirdFood"),
             summary: String(localized: "Winter delight to make for a cozy backyard.", table: "BirdFood")
         ))
         
         for food in try! modelContext.fetch(FetchDescriptor<BirdFood>()) {
             if let quantity = DataGenerationOptions.initialOwnedBirdFoods[food.id] {
                 food.ownedQuantity = quantity
             }
         }
         logger.info("Completed generating all of the bird food.")
     }
}
