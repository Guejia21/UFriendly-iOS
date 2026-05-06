import SwiftUI


struct TaskSection: View {
    let title: String
    let tasks: [Task] // TODO: Importar el modelo de datos para esto
    let onCheckedChange:(Task,Bool) -> Void // TODO: Crear la función para esto
    let onItemClick:(Task) -> Void // TODO: Crear la función para esto
    let onDeleteClick:(Task) -> Void // TODO: Crear la función para esto
    var body: some View {
        //Aquí va la sección de tareas, se deben separar entre hoy, pendientes y vencidas
    }
    
}

#Preview {
    TaskSection()
}