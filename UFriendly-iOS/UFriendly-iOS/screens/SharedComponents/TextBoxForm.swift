import SwiftUI

struct TextBoxForm: View {
    let label: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isNumber: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            TextField(label, text: $text)
                .keyboardType(keyboardType)
                .textFieldStyle(.roundedBorder)
        }
    }
}
