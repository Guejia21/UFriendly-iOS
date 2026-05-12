import SwiftUI
import SwiftData

struct AddSubjectScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var name = ""
    @State private var teacher = ""
    @State private var selectedColor: String?
    @State private var schedules: [ClassSchedule] = []
    @State private var showScheduleSheet = false

    private var isValid: Bool {
        !name.isBlank && !teacher.isBlank && selectedColor != nil
    }

    var body: some View {
        Form {
            Section("Subject Information") {
                TextField("Subject name", text: $name)
                TextField("Teacher", text: $teacher)
            }

            Section("Color") {
                ColorSelector(selectedColor: $selectedColor)
            }

            Section("Schedule") {
                ForEach(schedules, id: \.id) { schedule in
                    ScheduleCard(schedule: schedule) {
                        schedules.removeAll { $0.id == schedule.id }
                    }
                }
                AddScheduleButton {
                    showScheduleSheet = true
                }
            }
        }
        .navigationTitle("Add Subject")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { saveSubject() }
                    .disabled(!isValid)
            }
        }
        .sheet(isPresented: $showScheduleSheet) {
            ScheduleSheet { day, start, end in
                let schedule = ClassSchedule(day: day, startHour: start, endHour: end)
                schedules.append(schedule)
            }
        }
    }

    private func saveSubject() {
        let subject = Subject(
            name: name,
            teacher: teacher,
            score: 0.0,
            completionPercentage: 0,
            color: selectedColor ?? "#30628C"
        )
        context.insert(subject)
        for schedule in schedules {
            schedule.subject = subject
            context.insert(schedule)
        }
        try? context.save()
        dismiss()
    }
}

extension String {
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
