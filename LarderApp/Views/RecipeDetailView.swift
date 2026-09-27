import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @Bindable var libraryVM: RecipeLibraryViewModel

    private var servings: Int { libraryVM.servings(for: recipe) }
    private var scale: Double { Double(servings) / Double(max(recipe.baseServings, 1)) }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Rectangle()
                    .fill(Color.accentColor.opacity(0.7))
                    .frame(height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(recipe.title).font(.title2.bold())

                HStack {
                    Text("Servings")
                    Spacer()
                    Stepper(value: Binding(
                        get: { servings },
                        set: { libraryVM.setServings($0, for: recipe) }
                    ), in: 1...20) {
                        Text("\(servings)").monospacedDigit()
                    }
                    .fixedSize()
                }
                .padding(12)
                .background(.quaternary.opacity(0.3), in: RoundedRectangle(cornerRadius: 12))

                Text("Ingredients").font(.headline)
                ForEach(recipe.ingredients) { ingredient in
                    VStack(spacing: 0) {
                        HStack {
                            Text((ingredient.quantity * scale).quantityString)
                                .foregroundStyle(.secondary)
                                .monospacedDigit()
                            Text(ingredient.unit)
                                .foregroundStyle(.secondary)
                            Text(ingredient.name)
                            Spacer()
                        }
                        Divider()
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
