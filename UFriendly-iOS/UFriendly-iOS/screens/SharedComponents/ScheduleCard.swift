import SwiftUI

struct ScheduleCard: View {
    let schedule: ClassSchedule
    let onDelete: () -> Void

    var body: some View {
        HStack {
            Text(schedule.day.prefix(3))
                .font(.caption)
                .fontWeight(.bold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(6)
            Text("\(schedule.startHour) - \(schedule.endHour)")
                .font(.subheadline)
            Spacer()
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
