import SwiftUI

struct TaskItem: View {
    let task: Task
    let onCheckedChange: (Bool) -> Void
    let onDelete: () -> Void
    let onItemClick: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                // Checkbox
                Button(action: {
                    onCheckedChange(!task.isDone)
                }) {
                    Image(systemName: task.isDone ? "checkmark.square.fill" : "square")
                        .font(.system(size: 20))
                        .foregroundColor(task.isDone ? .blue : .gray)
                }
                
                // Contenido
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.name)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .strikethrough(task.isDone, color: .gray)
                    
                    let dateStr = formatDate(task.dueDate)
                    let subjectName = task.subject?.name ?? "Sin asignatura"
                    
                    Text("\(subjectName) - \(dateStr)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Botón delete
                Button(action: onDelete) {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .contentShape(Rectangle())
            .onTapGesture(perform: onItemClick)
        }
        .background(Color(.systemBackground))
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "Sin fecha" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Subject.self, Task.self, configurations: config)
    
    let subject = Subject(name: "Matemáticas", teacher: "Prof. García", score: 8.5, completionPercentage: 75, color: "blue")
    let task = Task(name: "Tarea de cálculo", description: "Resolver ejercicios 1-10", dueDate: Date(), isDone: false, subject: subject)
    
    return TaskItem(
        task: task,
        onCheckedChange: { _ in },
        onDelete: { },
        onItemClick: { }
    )
    .modelContainer(container)
    .padding()
}
