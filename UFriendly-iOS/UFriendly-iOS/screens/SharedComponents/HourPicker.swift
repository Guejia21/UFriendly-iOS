import SwiftUI

struct HourPicker: View {
    let label: String
    @Binding var selectedHour: String?

    private let hours: [String] = {
        var result: [String] = []
        for h in 6...20 {
            result.append(String(format: "%02d:00", h))
            if h != 20 { result.append(String(format: "%02d:30", h)) }
        }
        return result
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Menu {
                ForEach(hours, id: \.self) { hour in
                    Button(hour) { selectedHour = hour }
                }
            } label: {
                HStack {
                    Text(selectedHour ?? "Select hour")
                        .foregroundColor(selectedHour == nil ? .gray : .primary)
                    Spacer()
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
}
