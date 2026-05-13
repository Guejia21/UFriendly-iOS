import SwiftUI

struct DaySelector: View {
    @Binding var selectedDay: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Days")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack(spacing: 8) {
                DayButton(day: "Monday", isSelected: selectedDay == "Monday") { selectedDay = selectedDay == "Monday" ? nil : "Monday" }
                DayButton(day: "Tuesday", isSelected: selectedDay == "Tuesday") { selectedDay = selectedDay == "Tuesday" ? nil : "Tuesday" }
                DayButton(day: "Wednesday", isSelected: selectedDay == "Wednesday") { selectedDay = selectedDay == "Wednesday" ? nil : "Wednesday" }
                DayButton(day: "Thursday", isSelected: selectedDay == "Thursday") { selectedDay = selectedDay == "Thursday" ? nil : "Thursday" }
                DayButton(day: "Friday", isSelected: selectedDay == "Friday") { selectedDay = selectedDay == "Friday" ? nil : "Friday" }
                DayButton(day: "Saturday", isSelected: selectedDay == "Saturday") { selectedDay = selectedDay == "Saturday" ? nil : "Saturday" }
            }
        }
    }
}

struct DayButton: View {
    let day: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Text(day.prefix(3))
            .font(.caption)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(8)
            .contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
}
