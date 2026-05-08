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
    
    // Separar tareas en secciones
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
            // Botones de filtro
            HStack(spacing: 8) {
                FilterButton(
                    label: "Pendientes",
                    isSelected: filterSelected == "Pending",
                    action: { filterSelected = "Pending" }
                )
                FilterButton(
                    label: "Todas",
                    isSelected: filterSelected == "All",
                    action: { filterSelected = "All" }
                )
                FilterButton(
                    label: "Realizadas",
                    isSelected: filterSelected == "Done",
                    action: { filterSelected = "Done" }
                )
                FilterButton(
                    label: "Vencidas",
                    isSelected: filterSelected == "Expired",
                    action: { filterSelected = "Expired" }
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            // Lista de tareas con secciones
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    // Sección "Hoy"
                    if !todayTasks.isEmpty {
                        TaskSection(
                            title: "Hoy",
                            tasks: todayTasks,
                            onCheckedChange: handleTaskCheck,
                            onDelete: handleTaskDelete,
                            onItemClick: { _ in }
                        )
                    }
                    
                    // Sección "Próximas"
                    if !upcomingTasks.isEmpty {
                        TaskSection(
                            title: "Próximas",
                            tasks: upcomingTasks,
                            onCheckedChange: handleTaskCheck,
                            onDelete: handleTaskDelete,
                            onItemClick: { _ in }
                        )
                    }
                    
                    // Sección "Vencidas"
                    if !lateTasks.isEmpty {
                        TaskSection(
                            title: "Vencidas",
                            tasks: lateTasks,
                            onCheckedChange: handleTaskCheck,
                            onDelete: handleTaskDelete,
                            onItemClick: { _ in }
                        )
                    }
                    
                    // Mensaje vacío
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
    }
    
    private func handleTaskCheck(task: Task, isChecked: Bool) {
        task.isDone = isChecked
        try? context.save()
        successMessage = "Tarea actualizada"
    }
    
    private func handleTaskDelete(task: Task) {
        context.delete(task)
        try? context.save()
        successMessage = "Tarea eliminada"
    }
}

// MARK: - Filter Button
struct FilterButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    isSelected ?
                    Color.blue :
                    Color.gray.opacity(0.3)
                )
                .cornerRadius(8)
        }
    }
}

// MARK: - Date Helper Functions
func isToday(date: Date?) -> Bool {
    guard let date = date else { return false }
    let calendar = Calendar.current
    return calendar.isDateInToday(date)
}

func isExpired(date: Date?) -> Bool {
    guard let date = date else { return false }
    return date < Date()
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Subject.self, Task.self, configurations: config)
    
    let subject = Subject(name: "Matemáticas", teacher: "Prof. García", score: 8.5, completionPercentage: 75, color: "blue")
    
    let task1 = Task(name: "Tarea 1", description: "Descripción de la tarea 1", dueDate: Date().addingTimeInterval(3600), isDone: false, subject: subject)
    let task2 = Task(name: "Tarea 2", description: "Descripción de la tarea 2", dueDate: Date().addingTimeInterval(-3600), isDone: false, subject: subject)
    let task3 = Task(name: "Tarea 3", description: "Descripción de la tarea 3", dueDate: Date().addingTimeInterval(7200), isDone: true, subject: subject)
    
    container.mainContext.insert(task1)
    container.mainContext.insert(task2)
    container.mainContext.insert(task3)
    
    return TaskScreen()
        .modelContainer(container)
}
