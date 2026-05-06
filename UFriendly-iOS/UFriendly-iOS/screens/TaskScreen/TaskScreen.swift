import SwiftUI


struct TaskScreen: View {
    let taskList: [Task] // TODO: Importar el modelo de datos para esto
    
    @State private var filterSelected:String = "Pending"
    var filteredTasks: [Task] {
        switch filterSelected {
        case "Pending":
            return taskList.filter { !$0.isDone }
        case "Completed":
            return taskList.filter { $0.isDone }
        case "Overdue":
            return taskList.filter { isExpired(date: $0.dueDate) && !$0.isDone }
        default:
            return taskList
        }
    }
    //Separar tareas entre hoy, pendientes y vencidas
    var todayTasks: [Task] {
        taskList.filter { isToday(date: $0.dueDate) }
    }

    var pendingTasks: [Task] {
        taskList.filter { !isToday(date: $0.dueDate) && !isExpired(date: $0.dueDate) }
    }

    var overdueTasks: [Task] {
        taskList.filter { isExpired(date: $0.dueDate) }
    }
    var body: some View {
        VStack {
            //Aquí va el filtro para las tareas
            HStack {
                //TODO: Configurar para que cuando el boton este presionado cambie de color
                Button("Pendientes") {
                    filterSelected = "Pending"
                }
                Button("Todas") {
                    filterSelected = "All"
                }
                Button("Realizadas") {
                    filterSelected = "Completed"
                }
                Button("Vencidas") {
                    filterSelected = "Overdue"
                }
            }
            if (todayTasks.count > 0) {
                Text("Hoy")
                    .font(.title2)
                    .fontWeight(.semibold)
                TaskSection(title: "Hoy", tasks: todayTasks)
            }
            if (pendingTasks.count > 0) {
                Text("Pendientes")
                    .font(.title2)
                    .fontWeight(.semibold)
                TaskSection(title: "Pendientes", tasks: pendingTasks)
            }
            if (overdueTasks.count > 0) {
                Text("Vencidas")
                    .font(.title2)
                    .fontWeight(.semibold)
                TaskSection(title: "Vencidas", tasks: pendingTasks)
            }
            //Mensaje vacío
            if(filteredTasks.count == 0) {
                Text("No hay tareas para mostrar")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
        }
    }
}
func isToday(date:Date?)->Bool{
    //Si la tarea no tiene fecha de vencimiento
    guard let date = date else { return false }
    let calendar = Calendar.current
    return calendar.isDateInToday(date)
}
func isExpired(date:Date?)->Bool{
    //Si la tarea no tiene fecha de vencimiento
    guard let date = date else { return false }
    return date < Date()
}

#Preview {
    let tasks = [
        Task(id: 1, name: "Tarea 1", description: "Descripción de la tarea 1", dueDate: Date().addingTimeInterval(3600), isDone: false, subjectId: 1),
        Task(id: 2, name: "Tarea 2", description: "Descripción de la tarea 2", dueDate: Date().addingTimeInterval(-3600), isDone: false, subjectId: 2),
        Task(id: 3, name: "Tarea 3", description: "Descripción de la tarea 3", dueDate: Date().addingTimeInterval(7200), isDone: true, subjectId: 3)
    ]
    TaskScreen(taskList: tasks)
}
