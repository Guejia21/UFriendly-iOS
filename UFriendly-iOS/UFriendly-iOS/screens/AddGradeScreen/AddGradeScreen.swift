import SwiftUI
import SwiftData

struct AddGradeScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Query private var subjects: [Subject]

    @State private var name = ""
    @State private var valueText = ""
    @State private var weightText = ""
    @State private var date: Date?
    @State private var selectedSubjectIndex: Int?

    private var isValid: Bool {
        !name.isBlank &&
        (Double(valueText) ?? 0) >= 0 &&
        (Double(weightText) ?? 0) > 0 &&
        (Double(weightText) ?? 0) <= 1.0 &&
        date != nil &&
        selectedSubjectIndex != nil
    }

    var subjectItems: [(String, Any?)] {
        subjects.map { ($0.name, $0 as Any?) }
    }

    var body: some View {
        Form {
            Section("Grade Information") {
                TextField("Grade name", text: $name)
                TextField("Value", text: $valueText)
                    .keyboardType(.decimalPad)
                TextField("Weight (0.0 - 1.0)", text: $weightText)
                    .keyboardType(.decimalPad)
            }

            Section("Details") {
                DatePickerView(label: "Date", date: $date)

                if subjects.isEmpty {
                    Text("Create a subject first")
                        .foregroundColor(.secondary)
                } else {
                    ComboBox(
                        label: "Subject",
                        items: subjectItems,
                        selectedIndex: $selectedSubjectIndex,
                        placeholder: "Select subject"
                    )
                }
            }
        }
        .navigationTitle("Add Grade")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { saveGrade() }
                    .disabled(!isValid)
            }
        }
    }

    private func saveGrade() {
        guard let subjectIndex = selectedSubjectIndex,
              let value = Double(valueText),
              let weight = Double(weightText) else { return }

        let grade = Grade(
            name: name,
            value: value,
            weight: weight,
            date: date,
            subject: subjects[subjectIndex]
        )
        context.insert(grade)

        if let subject = grade.subject {
            let totalWeight = min(subject.grades.reduce(0) { $0 + $1.weight }, 1.0)
            let score = subject.grades.reduce(0) { $0 + $1.value * $1.weight }
            subject.score = score
            subject.completionPercentage = Int(totalWeight * 100)
        }

        try? context.save()
        dismiss()
    }
}
