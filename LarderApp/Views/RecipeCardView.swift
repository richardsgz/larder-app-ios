import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    let servings: Int
    let isSelecting: Bool
    let isPicked: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(Color.accentColor.opacity(0.7))
                .frame(height: 64)
                .overlay(alignment: .topTrailing) {
                    if isSelecting {
                        Image(systemName: isPicked ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(.white, isPicked ? Color.teal : .white.opacity(0.6))
                            .padding(6)
                    }
                }

            VStack(alignment: .leading, spacing: 2) {
                Text(recipe.title).font(.subheadline.weight(.semibold))
                Text(servings == recipe.baseServings ? "Serves \(recipe.baseServings)" : "Serves \(servings) (adjusted)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(8)
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(.separator))
    }
}
