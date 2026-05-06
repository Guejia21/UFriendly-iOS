import SwiftUI


struct MainScreen: View {
    let state: DashboardState // TODO: Importar el modelo de datos para esto

    var body: some View {
        //Se deben poner los argumentos
        VStack {
            WelcomeDashboard(state: state)
            Spacer()
            SubjectDashboard()
        }
    }
}


#Preview {
    MainScreen(state: DashboardState(pendingTasks: 5, completedTasks: 10, overdueTasks: 2))
}