import SwiftUI

struct SubjectFilterButtons: View {
    @Binding var selected: Int

    var body: some View {
        HStack(spacing: 20) {
            Button("Cursando") {
                selected = 0
            }
            .frame(width: 130, height: 45)
            .background(selected == 0 ? Color.purple.opacity(0.7) : Color.gray.opacity(0.3))
            .foregroundColor(.white)
            .cornerRadius(12)

            Button("Cursadas") {
                selected = 1
            }
            .frame(width: 130, height: 45)
            .background(selected == 1 ? Color.blue : Color.gray.opacity(0.3))
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}
