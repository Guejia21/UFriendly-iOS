import SwiftUI

struct TopBarView: View {
    let title: String

    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                Text("Atrás")
            }
            .foregroundColor(.accentColor)

            Spacer()

            Text(title)
                .font(.headline)

            Spacer()

            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
            .foregroundColor(.accentColor)
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
        .background(Color(UIColor.systemBackground))
        .overlay(Divider(), alignment: .bottom)
    }
}