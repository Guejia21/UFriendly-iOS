import SwiftUI


struct WelcomeDashboard: View {
    let state: DashboardState // TODO: Importar el modelo de datos para esto
    let onViewAllClick: () -> Void = {} // TODO: Crear la función para esto
    var body: some View {
        VStack {
            Text("¡Welcome!")
                .font(.title)
                .fontWeight(.semibold)
            VStack(alignment: .leading, spacing: 16) {
                HStack{
                    Text("Resumen de tareas")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Button("Ver todas"){
                        onViewAllClick()
                    }
                }
                .padding(.bottom, 8)
                HStack{
                    //Aqui van las tarjetas de pendientes, realizadas y vencidas
                    TaskSummaryCard(title: "Pendientes", count: state.pendingTasks, iconName: "pause.fill", color: .blue)
                    TaskSummaryCard(title: "Realizadas", count: state.completedTasks, iconName: "checkmark.circle", color: .green)
                    TaskSummaryCard(title: "Vencidas", count: state.overdueTasks, iconName: "exclamationmark.triangle", color: .red)
                }
            }
        }
        .background(.tint, in: RoundedRectangle(cornerRadius: 12))
        .padding()
}

#Preview {
    WelcomeDashboard(state: DashboardState(pendingTasks: 5, completedTasks: 10, overdueTasks: 2))
}

struct TaskSummaryCard: View {
    let title: String
    let count: Int
    let iconName: String = "pause.fill" // Ejemplo de icono, se puede personalizar según el tipo de tarea
    let color: Color

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.largeTitle) // Adjusts the size
                .foregroundColor(color) // Sets the icon color
            Text("\(count)")
                .font(.largeTitle)
                .fontWeight(.bold)                
            Text(title)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.gray, in: RoundedRectangle(cornerRadius: 12))
    }
}
#Preview {
    TaskSummaryCard(title: "Pendientes", count: 5, iconName: "pause.fill", color: .blue)
}