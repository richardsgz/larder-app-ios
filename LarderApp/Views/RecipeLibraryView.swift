import SwiftUI

struct RecipeLibraryView: View {
    let recipes: [Recipe]
    @Bindable var libraryVM: RecipeLibraryViewModel
    var listVM: ShoppingListViewModel

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(recipes) { recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: recipe, libraryVM: libraryVM)
                        } label: {
                            RecipeCardView(
                                recipe: recipe,
                                servings: libraryVM.servings(for: recipe),
                                isSelecting: libraryVM.isSelecting,
                                isPicked: libraryVM.selectedIDs.contains(recipe.id)
                            )
                        }
                        .buttonStyle(.plain)
                        .simultaneousGesture(TapGesture().onEnded {
                            if libraryVM.isSelecting {
                                libraryVM.toggleSelection(for: recipe)
                            }
                        })
                        // When selecting, the NavigationLink push is suppressed by disabling it.
                        .disabled(libraryVM.isSelecting)
                    }
                }
                .padding()
            }
            .navigationTitle("Larder")
            .toolbar {
                Button(libraryVM.isSelecting ? "Cancel" : "Select") {
                    libraryVM.isSelecting.toggle()
                    if !libraryVM.isSelecting { libraryVM.selectedIDs.removeAll() }
                }
            }
            .safeAreaInset(edge: .bottom) {
                if libraryVM.isSelecting && !libraryVM.selectedIDs.isEmpty {
                    SelectionTray(count: libraryVM.selectedIDs.count) {
                        listVM.build(from: libraryVM.buildSelections(from: recipes))
                        libraryVM.reset()
                    }
                }
            }
        }
    }
}

private struct SelectionTray: View {
    let count: Int
    let action: () -> Void

    var body: some View {
        HStack {
            Text("\(count) selected")
            Spacer()
            Button("Make list", action: action)
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}
