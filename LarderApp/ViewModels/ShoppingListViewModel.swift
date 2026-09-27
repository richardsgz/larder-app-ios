import Foundation
import Observation

@Observable
final class ShoppingListViewModel {
    var groupedItems: [IngredientCategory: [MergedIngredient]] = [:]
    private var checkedNames: Set<String> = []

    func build(from selections: [(recipe: Recipe, servings: Int)]) {
        let merged = IngredientMerger.merge(selections: selections)
        groupedItems = Dictionary(grouping: merged, by: \.category)
        checkedNames.removeAll()
    }

    func toggle(_ item: MergedIngredient) {
        if checkedNames.contains(item.name) {
            checkedNames.remove(item.name)
        } else {
            checkedNames.insert(item.name)
        }
    }

    func isChecked(_ item: MergedIngredient) -> Bool {
        checkedNames.contains(item.name)
    }

    func clear() {
        groupedItems.removeAll()
        checkedNames.removeAll()
    }
}
