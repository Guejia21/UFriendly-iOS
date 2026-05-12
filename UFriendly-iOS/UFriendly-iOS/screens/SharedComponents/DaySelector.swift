import SwiftUI

struct DaySelector: View {
    @Binding var selectedDays: Set<String>

    private let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Days")
                .font(.subheadline)
                .foregroundColor(.secondary)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                ForEach(days, id: \.self) { day in
                    Button(action: {
                        if selectedDays.contains(day) {
                            selectedDays.remove(day)
                        } else {
                            selectedDays.insert(day)
                        }
                    }) {
                        Text(day.prefix(3))
                            .font(.caption)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(selectedDays.contains(day) ? Color.blue : Color(.systemGray6))
                            .foregroundColor(selectedDays.contains(day) ? .white : .primary)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}
