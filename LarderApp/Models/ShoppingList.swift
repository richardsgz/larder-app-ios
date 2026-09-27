import Foundation
import SwiftData

@Model
final class ShoppingList {
    var id: UUID
    var createdAt: Date
    var sourceRecipeIDs: [UUID]

    @Relationship(deleteRule: .cascade, inverse: \ShoppingItem.list)
    var items: [ShoppingItem] = []

    init(sourceRecipeIDs: [UUID]) {
        self.id = UUID()
        self.createdAt = .now
        self.sourceRecipeIDs = sourceRecipeIDs
    }
}

@Model
final class ShoppingItem {
    var id: UUID
    var canonicalName: String
    var quantity: Double
    var unit: String
    var category: IngredientCategory
    var isChecked: Bool
    var contributingRecipeTitles: [String]
    var list: ShoppingList?

    init(canonicalName: String, quantity: Double, unit: String,
         category: IngredientCategory, contributingRecipeTitles: [String]) {
        self.id = UUID()
        self.canonicalName = canonicalName
        self.quantity = quantity
        self.unit = unit
        self.category = category
        self.isChecked = false
        self.contributingRecipeTitles = contributingRecipeTitles
    }
}
