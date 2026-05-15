import SwiftUI

struct FloatingFabMenu: View {
    let onAddSubject: () -> Void
    let onAddTask: () -> Void
    let onAddGrade: () -> Void

    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 12) {
            if isExpanded {
                FabMenuItem(icon: "book.fill", label: "Subject", color: .blue, action: {
                    isExpanded = false
                    onAddSubject()
                })
                FabMenuItem(icon: "checklist", label: "Task", color: .green, action: {
                    isExpanded = false
                    onAddTask()
                })
                FabMenuItem(icon: "star.fill", label: "Grade", color: .orange, action: {
                    isExpanded = false
                    onAddGrade()
                })
            }
            Button(action: { withAnimation(.spring(response: 0.3)) { isExpanded.toggle() } }) {
                Image(systemName: isExpanded ? "xmark" : "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
        }
        .padding()
    }
}

struct FabMenuItem: View {
    let icon: String
    let label: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                Text(label)
                    .font(.caption)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(color)
            .cornerRadius(8)
            .shadow(radius: 2)
        }
        .transition(.scale.combined(with: .opacity))
    }
}
