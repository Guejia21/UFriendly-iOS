import SwiftUI

struct DatePickerView: View {
    let label: String
    @Binding var date: Date?
    @State private var showPicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Button(action: { showPicker.toggle() }) {
                HStack {
                    Text(date.map { formatDate($0) } ?? "Select date")
                        .foregroundColor(date == nil ? .gray : .primary)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            .sheet(isPresented: $showPicker) {
                NavigationStack {
                    DatePicker("Select date", selection: Binding(
                        get: { date ?? Date() },
                        set: { date = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .navigationTitle(label)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") { showPicker = false }
                        }
                    }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}
