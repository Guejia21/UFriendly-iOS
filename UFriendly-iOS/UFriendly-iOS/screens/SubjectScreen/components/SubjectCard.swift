import SwiftUI

struct SubjectCard: View {
    let subject: Subject

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle()
                    .fill(Color(hex: subject.color))
                    .frame(width: 12, height: 12)
                Text(subject.name)
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
                VStack {
                    Text("\(subject.completionPercentage)%")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Text("Completed")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }

            if !subject.schedules.isEmpty {
                ForEach(subject.schedules.prefix(2), id: \.id) { schedule in
                    Text("\(schedule.day.prefix(3)): \(schedule.startHour) - \(schedule.endHour)")
                        .foregroundColor(.white.opacity(0.9))
                        .font(.caption)
                }
            }

            Text(subject.teacher)
                .foregroundColor(.white)

            Text("Score: \(subject.score, specifier: "%.2f")")
                .font(.title3)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.orange)
        .cornerRadius(20)
        .padding(.horizontal, 4)
    }
}
