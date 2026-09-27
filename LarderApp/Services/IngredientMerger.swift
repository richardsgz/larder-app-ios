import Foundation

struct MergedIngredient: Identifiable {
    let id = UUID()
    var name: String
    var quantity: Double
    var unit: String
    var category: IngredientCategory
    var contributingRecipes: [String]
}

/// Combines ingredients from several (recipe, chosen-servings) selections into
/// one shopping list. No UI or persistence dependencies, so it can be tested
/// with plain fixtures independent of SwiftData or SwiftUI.
struct IngredientMerger {

    static func merge(selections: [(recipe: Recipe, servings: Int)]) -> [MergedIngredient] {
        var buckets: [String: MergedIngredient] = [:]   // key: normalized name + unit family

        for (recipe, servings) in selections {
            let scale = Double(servings) / Double(max(recipe.baseServings, 1))

            for ingredient in recipe.ingredients {
                let name = normalize(ingredient.name)
                let scaledQty = ingredient.quantity * scale
                let family = UnitConverter.family(for: ingredient.unit)
                let bucketKey = "\(name)|\(family)"

                if var existing = buckets[bucketKey],
                   let converted = UnitConverter.convert(scaledQty, from: ingredient.unit, to: existing.unit) {
                    existing.quantity += converted
                    existing.contributingRecipes.append(recipe.title)
                    buckets[bucketKey] = existing
                } else {
                    buckets[bucketKey] = MergedIngredient(
                        name: name,
                        quantity: scaledQty,
                        unit: ingredient.unit,
                        category: ingredient.category,
                        contributingRecipes: [recipe.title]
                    )
                }
            }
        }

        return buckets.values.sorted { $0.category.rawValue < $1.category.rawValue }
    }

    /// Strips descriptive words so "fresh basil" and "basil" land in the same bucket.
    private static func normalize(_ raw: String) -> String {
        let stripped: Set<String> = ["fresh", "chopped", "diced", "sliced", "large", "small", "ripe"]
        let words = raw.lowercased().split(separator: " ").map(String.init)
        return words.filter { !stripped.contains($0) }.joined(separator: " ")
    }
}
