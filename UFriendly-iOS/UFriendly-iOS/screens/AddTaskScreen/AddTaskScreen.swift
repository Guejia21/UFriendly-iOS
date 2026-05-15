import SwiftUI
import SwiftData

struct AddTaskScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Query private var subjects: [Subject]

    @State private var name = ""
    @State private var description = ""
    @State private var dueDate: Date?
    @State private var selectedSubjectIndex: Int?

    private var isValid: Bool {
        !name.isBlank
    }

    var subjectItems: [(String, Any?)] {
        subjects.map { ($0.name, $0 as Any?) }
    }

    var body: some View {
        Form {
            Section("Task Information") {
                TextField("Task name", text: $name)
                TextField("Description", text: $description)
            }

            Section("Details") {
                DatePickerView(label: "Due date", date: $dueDate)

                if !subjects.isEmpty {
                    ComboBox(
                        label: "Subject",
                        items: subjectItems,
                        selectedIndex: $selectedSubjectIndex,
                        placeholder: "Select subject (optional)"
                    )
                }
            }
        }
        .background(.primaryContainer)
        .navigationTitle("Add Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { saveTask() }
                    .disabled(!isValid)
            }
        }
    }

    private func saveTask() {
        let subject = selectedSubjectIndex.map { subjects[$0] }
        let task = Task(
            name: name,
            description: description,
            dueDate: dueDate,
            isDone: false,
            subject: subject
        )
        context.insert(task)
        try? context.save()
        dismiss()
    }
}
