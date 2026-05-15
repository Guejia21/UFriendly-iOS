import SwiftUI

struct GradeCard: View {
    let grade: Grade

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(grade.name)
                    .font(.headline)
                Spacer()
                Text("\(grade.value, specifier: "%.1f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(grade.value >= 3.0 ? .green : .red)
            }
            HStack {
                Text("Weight: \(grade.weight * 100, specifier: "%.0f")%")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("Partial: \(grade.value * grade.weight, specifier: "%.2f")")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            if let date = grade.date {
                Text(formatDate(date))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
