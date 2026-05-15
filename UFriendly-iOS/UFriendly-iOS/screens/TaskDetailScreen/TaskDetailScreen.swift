import SwiftUI
import SwiftData

struct TaskDetailScreen: View {
    let task: Task
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var successMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let message = successMessage {
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text(task.name)
                        .font(.title)
                        .fontWeight(.bold)

                    if let subject = task.subject {
                        HStack {
                            Circle()
                                .fill(Color(hex: subject.color))
                                .frame(width: 10, height: 10)
                            Text(subject.name)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }

                    if let dueDate = task.dueDate {
                        Label(formatDate(dueDate), systemImage: "calendar")
                            .font(.subheadline)
                            .foregroundColor(isExpired(date: dueDate) && !task.isDone ? .red : .secondary)
                    }

                    if !task.taskDescription.isEmpty {
                        Divider()
                        Text("Description")
                            .font(.headline)
                        Text(task.taskDescription)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()

                Divider()

                VStack(spacing: 16) {
                    Button(action: toggleDone) {
                        HStack {
                            Image(systemName: task.isDone ? "arrow.uturn.backward" : "checkmark.circle.fill")
                            Text(task.isDone ? "Mark as pending" : "Mark as done")
                        }
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(task.isDone ? Color.orange : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }

                    Button(action: deleteTask) {
                        HStack {
                            Image(systemName: "trash.fill")
                            Text("Delete")
                        }
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(.primaryContainer)
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func toggleDone() {
        task.isDone.toggle()
        try? context.save()
        withAnimation {
            successMessage = task.isDone ? "Task completed!" : "Task reopened"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            dismiss()
        }
    }

    private func deleteTask() {
        context.delete(task)
        try? context.save()
        dismiss()
    }
}
