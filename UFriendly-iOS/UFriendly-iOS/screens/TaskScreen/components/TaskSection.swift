import SwiftUI

struct TaskSection: View {
    let title: String
    let tasks: [Task]
    let onCheckedChange: (Task, Bool) -> Void
    let onDelete: (Task) -> Void
    let onItemClick: (Task) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            VStack(spacing: 4) {
                ForEach(tasks, id: \.id) { task in
                    TaskItem(
                        task: task,
                        onCheckedChange: { isChecked in
                            onCheckedChange(task, isChecked)
                        },
                        onDelete: {
                            onDelete(task)
                        },
                        onItemClick: {
                            onItemClick(task)
                        }
                    )
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Subject.self, Task.self, configurations: config)
    
    let subject = Subject(name: "Cálculo I", teacher: "Prof. García", score: 8.5, completionPercentage: 75, color: "blue")
    let tasks = [
        Task(name: "Preparar presentación", description: "Desc", dueDate: Date(), isDone: false, subject: subject),
        Task(name: "Estudiar temas 1-5", description: "Desc", dueDate: Date(), isDone: false, subject: subject),
        Task(name: "Proyecto final", description: "Desc", dueDate: Date(), isDone: true, subject: subject)
    ]
    
    return TaskSection(
        title: "Hoy",
        tasks: tasks,
        onCheckedChange: { _, _ in },
        onDelete: { _ in },
        onItemClick: { _ in }
    )
    .modelContainer(container)
    .padding()
}
