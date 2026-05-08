import SwiftUI


struct TaskSection: View {
    let title: String
    let tasks: [Task] // TODO: Importar el modelo de datos para esto
    let onCheckedChange:(Task,Bool) -> Void = {_,_ in } // TODO: Crear la función para esto
    let onItemClick:(Task) -> Void = {_ in }// TODO: Crear la función para esto
    let onDeleteClick:(Task) -> Void = {_ in } // TODO: Crear la función para esto
    var body: some View {
        //Aquí va la sección de tareas, se deben separar entre hoy, pendientes y vencidas
    }
    
}
/*
 #Preview {
 let tasks = [
 Task(id: 1, name: "Tarea 1", description: "Descripción de la tarea 1", dueDate: Date().addingTimeInterval(3600), isDone: false, subjectId: 1),
 Task(id: 2, name: "Tarea 2", description: "Descripción de la tarea 2", dueDate: Date().addingTimeInterval(-3600), isDone: false, subjectId: 2),
 Task(id: 3, name: "Tarea 3", description: "Descripción de la tarea 3", dueDate: Date().addingTimeInterval(7200), isDone: true, subjectId: 3)
 ]
 TaskSection(title: "Hoy", tasks: tasks)
 }
 */
