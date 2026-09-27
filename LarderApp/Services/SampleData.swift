import Foundation
import SwiftData

/// Inserts a handful of recipes on first launch (only when the library is empty).
/// Temporary: remove once the app has its own "add recipe" screen.
enum SampleData {

    private typealias Ing = (name: String, qty: Double, unit: String, cat: IngredientCategory)
    private typealias Spec = (title: String, servings: Int, tags: [String], ingredients: [Ing])

    private static let specs: [Spec] = [
        ("Banana Bread", 4, ["baking"], [
            ("flour", 2, "cup", .pantry), ("ripe bananas", 3, "", .produce),
            ("sugar", 0.75, "cup", .pantry), ("butter", 0.5, "cup", .dairy), ("eggs", 2, "", .dairy)
        ]),
        ("Pancakes", 4, ["breakfast"], [
            ("flour", 1.5, "cup", .pantry), ("eggs", 2, "", .dairy), ("milk", 1.25, "cup", .dairy),
            ("butter", 0.25, "cup", .dairy), ("sugar", 2, "tbsp", .pantry)
        ]),
        ("Tomato Pasta", 4, ["dinner"], [
            ("pasta", 400, "g", .pantry), ("tomatoes", 6, "", .produce), ("garlic", 3, "clove", .produce),
            ("basil", 1, "bunch", .herbs), ("parmesan", 50, "g", .dairy)
        ]),
        ("Garlic Bread", 4, ["side"], [
            ("baguette", 1, "", .pantry), ("garlic", 4, "clove", .produce),
            ("butter", 0.33, "cup", .dairy), ("parsley", 1, "bunch", .herbs)
        ]),
        ("Veg Stir-fry", 4, ["dinner"], [
            ("broccoli", 1, "head", .produce), ("garlic", 2, "clove", .produce),
            ("soy sauce", 3, "tbsp", .pantry), ("tofu", 400, "g", .protein)
        ]),
        ("Greek Salad", 4, ["lunch"], [
            ("tomatoes", 4, "", .produce), ("cucumber", 1, "", .produce),
            ("feta", 200, "g", .dairy), ("olives", 100, "g", .pantry)
        ])
    ]

    @MainActor
    static func seedIfNeeded(in context: ModelContext) {
        let existing = (try? context.fetchCount(FetchDescriptor<Recipe>())) ?? 0
        guard existing == 0 else { return }

        for spec in specs {
            let recipe = Recipe(title: spec.title, baseServings: spec.servings, tags: spec.tags)
            context.insert(recipe)
            for ing in spec.ingredients {
                recipe.ingredients.append(
                    RecipeIngredient(name: ing.name, quantity: ing.qty, unit: ing.unit, category: ing.cat)
                )
            }
        }
        try? context.save()
    }
}
