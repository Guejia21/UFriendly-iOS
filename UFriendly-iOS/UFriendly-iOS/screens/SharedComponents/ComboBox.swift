import SwiftUI

struct ComboBox: View {
    let label: String
    let items: [(String, Any?)]
    @Binding var selectedIndex: Int?
    var placeholder: String = "Select..."

    var selectedLabel: String {
        guard let idx = selectedIndex, idx < items.count else { return placeholder }
        return items[idx].0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Menu {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    Button(item.0) {
                        selectedIndex = index
                    }
                }
            } label: {
                HStack {
                    Text(selectedLabel)
                        .foregroundColor(selectedIndex == nil ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
}
