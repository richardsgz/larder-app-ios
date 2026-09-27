import Foundation
import SwiftData

enum IngredientCategory: String, Codable, CaseIterable {
    case produce, protein, dairy, herbs, pantry, other
}

@Model
final class RecipeIngredient {
    var id: UUID
    var name: String
    var quantity: Double
    var unit: String            // "cup", "g", "clove" — empty string means a bare count
    var category: IngredientCategory
    var recipe: Recipe?

    init(name: String, quantity: Double, unit: String, category: IngredientCategory) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.category = category
    }
}
