import Foundation
import SwiftData

@Model
final class Recipe {
    var id: UUID
    var title: String
    var baseServings: Int
    var tags: [String]
    var sourceURL: String?

    @Relationship(deleteRule: .cascade, inverse: \RecipeIngredient.recipe)
    var ingredients: [RecipeIngredient] = []

    init(title: String, baseServings: Int = 4, tags: [String] = [], sourceURL: String? = nil) {
        self.id = UUID()
        self.title = title
        self.baseServings = baseServings
        self.tags = tags
        self.sourceURL = sourceURL
    }
}
