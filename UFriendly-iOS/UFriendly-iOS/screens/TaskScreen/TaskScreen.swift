import SwiftUI
import SwiftData

struct TaskScreen: View {
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var context

    @State private var filterSelected: String = "Pending"
    @State private var successMessage: String?

    var filteredTasks: [Task] {
        switch filterSelected {
        case "Pending":
            return tasks.filter { !$0.isDone }
        case "Done":
            return tasks.filter { $0.isDone }
        case "Expired":
            return tasks.filter { isExpired(date: $0.dueDate) && !$0.isDone }
        default:
            return tasks
        }
    }

    var todayTasks: [Task] {
        filteredTasks.filter { isToday(date: $0.dueDate) }
    }

    var upcomingTasks: [Task] {
        filteredTasks.filter { !isToday(date: $0.dueDate) && !isExpired(date: $0.dueDate) }
    }

    var lateTasks: [Task] {
        filteredTasks.filter { isExpired(date: $0.dueDate) }
    }

    var body: some View {
        VStack(spacing: 0) {
            if let message = successMessage {
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }

            HStack(spacing: 8) {
                FilterButton(label: "Pendientes", isSelected: filterSelected == "Pending", action: { filterSelected = "Pending" })
                FilterButton(label: "Todas", isSelected: filterSelected == "All", action: { filterSelected = "All" })
                FilterButton(label: "Realizadas", isSelected: filterSelected == "Done", action: { filterSelected = "Done" })
                FilterButton(label: "Vencidas", isSelected: filterSelected == "Expired", action: { filterSelected = "Expired" })
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if !todayTasks.isEmpty {
                        TaskSection(
                            title: "Hoy",
                            tasks: todayTasks,
                            onCheckedChange: handleTaskCheck,
                            onDelete: handleTaskDelete,                
                        )
                    }
                    if !upcomingTasks.isEmpty {
                        TaskSection(
                            title: "Proximas",
                            tasks: upcomingTasks,
                            onCheckedChange: handleTaskCheck,
                            onDelete: handleTaskDelete,                        
                        )
                    }
                    if !lateTasks.isEmpty {
                        TaskSection(
                            title: "Vencidas",
                            tasks: lateTasks,
                            onCheckedChange: handleTaskCheck,
                            onDelete: handleTaskDelete,
                        )
                    }
                    if filteredTasks.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                            Text("No hay tareas \(filterSelected.lowercased())")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(32)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Tasks")
    }

    private func handleTaskCheck(task: Task, isChecked: Bool) {
        task.isDone = isChecked
        try? context.save()
        withAnimation {
            successMessage = isChecked ? "Task completed!" : "Task reopened"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation { successMessage = nil }
        }
    }

    private func handleTaskDelete(task: Task) {
        NotificationManager.cancelReminder(taskId: task.id)
        context.delete(task)
        try? context.save()
        withAnimation {
            successMessage = "Task deleted"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation { successMessage = nil }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Subject.self, Task.self, configurations: config)

    let subject = Subject(name: "Matematicas", teacher: "Prof. Garcia", score: 8.5, completionPercentage: 75, color: "blue")

    let task1 = Task(name: "Tarea 1", description: "Descripcion 1", dueDate: Date().addingTimeInterval(3600), isDone: false, subject: subject)
    let task2 = Task(name: "Tarea 2", description: "Descripcion 2", dueDate: Date().addingTimeInterval(-3600), isDone: false, subject: subject)
    let task3 = Task(name: "Tarea 3", description: "Descripcion 3", dueDate: Date().addingTimeInterval(7200), isDone: true, subject: subject)

    container.mainContext.insert(task1)
    container.mainContext.insert(task2)
    container.mainContext.insert(task3)

    return NavigationStack { TaskScreen() }
        .modelContainer(container)
}
