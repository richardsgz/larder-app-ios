import SwiftUI

struct ShoppingListView: View {
    @Bindable var listVM: ShoppingListViewModel

    private let order: [IngredientCategory] = [.produce, .protein, .dairy, .herbs, .pantry, .other]

    var body: some View {
        NavigationStack {
            List {
                if listVM.groupedItems.isEmpty {
                    ContentUnavailableView(
                        "No list yet",
                        systemImage: "cart",
                        description: Text("Select recipes in your library, then tap Make list.")
                    )
                }
                ForEach(order.filter { listVM.groupedItems[$0] != nil }, id: \.self) { category in
                    Section(category.rawValue.capitalized) {
                        ForEach(listVM.groupedItems[category] ?? []) { item in
                            ShoppingRow(item: item, isChecked: listVM.isChecked(item)) {
                                listVM.toggle(item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Shopping List")
            .toolbar {
                if !listVM.groupedItems.isEmpty {
                    Button("Clear", role: .destructive) { listVM.clear() }
                }
            }
        }
    }
}

private struct ShoppingRow: View {
    let item: MergedIngredient
    let isChecked: Bool
    let toggle: () -> Void

    var body: some View {
        Button(action: toggle) {
            HStack(alignment: .top) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(isChecked ? Color.teal : .secondary)
                VStack(alignment: .leading) {
                    Text("\(item.quantity.quantityString) \(item.unit) \(item.name)")
                        .strikethrough(isChecked)
                        .foregroundStyle(isChecked ? .secondary : .primary)
                    Text(Array(Set(item.contributingRecipes)).joined(separator: " + "))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
