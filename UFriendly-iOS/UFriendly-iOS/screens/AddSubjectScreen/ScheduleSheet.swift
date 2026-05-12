import SwiftUI

struct ScheduleSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDays: Set<String> = []
    @State private var startHour: String?
    @State private var endHour: String?

    let onAdd: (String, String, String) -> Void

    var isValid: Bool {
        !selectedDays.isEmpty && startHour != nil && endHour != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Days") {
                    DaySelector(selectedDays: $selectedDays)
                }
                Section("Hours") {
                    HourPicker(label: "Start", selectedHour: $startHour)
                    HourPicker(label: "End", selectedHour: $endHour)
                }
            }
            .navigationTitle("Add Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        for day in selectedDays {
                            onAdd(day, startHour!, endHour!)
                        }
                        dismiss()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
}
