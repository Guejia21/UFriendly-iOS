import SwiftUI


struct WelcomeDashboard: View {
    let state: DashboardState // TODO: Importar el modelo de datos para esto
    let onViewAllClick: () -> Void = {} // TODO: Crear la función para esto
    var body: some View {
        VStack(alignment: .leading) {
            Text("¡Welcome!")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
                .foregroundStyle(.white)
            VStack(alignment: .leading) {
                HStack{
                    Text("Resumen de tareas")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    PersonalizedButton(label:"Ver todas"){
                        onViewAllClick()
                    }
                }
                .padding(.horizontal,12)
                .padding(.top,4)
                HStack{
                    //Aqui van las tarjetas de pendientes, realizadas y vencidas
                    TaskSummaryCard(title: "Pendientes", count: state.pendingTasks, iconName: "pause.fill", color: .blue)
                    TaskSummaryCard(title: "Realizadas", count: state.completedTasks, iconName: "checkmark.circle", color: .green)
                    TaskSummaryCard(title: "Vencidas", count: state.overdueTasks, iconName: "exclamationmark.triangle", color: .red)
                }
                .aspectRatio(contentMode: .fit)
                .padding()
            }
            .background(.white, in: RoundedRectangle(cornerRadius: 12))
            .padding()
        }
        .background(.primaryC, in: RoundedRectangle(cornerRadius: 12))
        .padding()
    }
}

#Preview {
    WelcomeDashboard(state: DashboardState(pendingTasks: 5, completedTasks: 10, overdueTasks: 2))
}

struct TaskSummaryCard: View {
    let title: String
    let count: Int
    let iconName: String // Ejemplo de icono, se puede personalizar según el tipo de tarea
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
                .aspectRatio(contentMode: .fill)
        }
        .frame(maxWidth: 100,maxHeight: 100)
        .padding()
        .background(.secondaryContainer, in: RoundedRectangle(cornerRadius: 12))
    }
}
#Preview {
    TaskSummaryCard(title: "Pendientes", count: 5, iconName: "pause.fill", color: .blue)
}
