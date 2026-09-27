import SwiftUI
import SwiftData

struct RootTabView: View {
    @Query private var recipes: [Recipe]
    @State private var libraryVM = RecipeLibraryViewModel()
    @State private var listVM = ShoppingListViewModel()

    var body: some View {
        TabView {
            RecipeLibraryView(recipes: recipes, libraryVM: libraryVM, listVM: listVM)
                .tabItem { Label("Recipes", systemImage: "square.grid.2x2") }

            ShoppingListView(listVM: listVM)
                .tabItem { Label("List", systemImage: "cart") }
        }
    }
}
