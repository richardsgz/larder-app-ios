import Foundation
import Observation

@Observable
final class RecipeLibraryViewModel {
    var isSelecting = false
    var selectedIDs = Set<UUID>()

    /// Serving count chosen for each recipe, defaulting to its baseServings until adjusted
    /// on the detail screen. Kept here (not on Recipe) since it's transient, per-session state.
    private var servingOverrides: [UUID: Int] = [:]

    func toggleSelection(for recipe: Recipe) {
        if selectedIDs.contains(recipe.id) {
            selectedIDs.remove(recipe.id)
        } else {
            selectedIDs.insert(recipe.id)
            if servingOverrides[recipe.id] == nil {
                servingOverrides[recipe.id] = recipe.baseServings
            }
        }
    }

    func servings(for recipe: Recipe) -> Int {
        servingOverrides[recipe.id] ?? recipe.baseServings
    }

    func setServings(_ value: Int, for recipe: Recipe) {
        servingOverrides[recipe.id] = max(1, value)
    }

    func buildSelections(from recipes: [Recipe]) -> [(recipe: Recipe, servings: Int)] {
        recipes
            .filter { selectedIDs.contains($0.id) }
            .map { ($0, servings(for: $0)) }
    }

    func reset() {
        isSelecting = false
        selectedIDs.removeAll()
    }
}
