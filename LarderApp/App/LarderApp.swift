import SwiftUI
import SwiftData

@main
struct LarderApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(
                for: Recipe.self, RecipeIngredient.self, ShoppingList.self, ShoppingItem.self
            )
        } catch {
            fatalError("Could not create SwiftData container: \(error)")
        }
        SampleData.seedIfNeeded(in: container.mainContext)
    }

    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
        .modelContainer(container)
    }
}
