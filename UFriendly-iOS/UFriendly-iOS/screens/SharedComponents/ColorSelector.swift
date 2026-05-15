import SwiftUI

struct ColorSelector: View {
    @Binding var selectedColor: String?

    private let colors: [(name: String, color: Color)] = [
        ("#30628C", .blue),
        ("#D32F2F", .red),
        ("#FF9800", .orange),
        ("#9C27B0", .purple),
        ("#C084FC", Color(hex: "C084FC")),
        ("#4CAF50", .green),
        ("#FFEB3B", .yellow),
        ("#E91E63", .pink),
        ("#8B4513", Color(hex: "8B4513")),
        ("#FFD700", Color(hex: "FFD700"))
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Color")
                .font(.subheadline)
                .foregroundColor(.secondary)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(colors, id: \.name) { item in
                    Circle()
                        .fill(item.color)
                        .frame(width: 36, height: 36)
                        .overlay(
                            Circle()
                                .stroke(selectedColor == item.name ? Color.primary : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            selectedColor = item.name
                        }
                }
            }
        }
    }
}
