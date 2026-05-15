import SwiftUI

struct SubjectFullCard: View {
    let subject: Subject

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle()
                    .fill(Color(hex: subject.color))
                    .frame(width: 12, height: 12)
                Text(subject.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(subject.completionPercentage)%")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("Score: \(subject.score, specifier: "%.2f")")
                        .font(.caption)
                }
            }
            if !subject.schedules.isEmpty {
                ForEach(subject.schedules, id: \.id) { schedule in
                    Label("\(schedule.day.prefix(3)) \(schedule.startHour)-\(schedule.endHour)",
                          systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Text(subject.teacher)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(hex: subject.color).opacity(0.15))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: subject.color).opacity(0.3), lineWidth: 1)
        )
    }
}
