import SwiftUI

struct FormCard<Content: View>: View {
    let title: String?
    let isValid: Bool
    let onSave: () -> Void
    @ViewBuilder let content: Content

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let title = title {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                content
                    .padding(.horizontal)
                Button(action: onSave) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(!isValid)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}
