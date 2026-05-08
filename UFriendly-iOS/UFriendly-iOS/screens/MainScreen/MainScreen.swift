import SwiftUI


struct MainScreen: View {
    let state: DashboardState // TODO: Importar el modelo de datos para esto
    let subjects:[Subject]
    
    var body: some View {
        VStack {
            WelcomeDashboard(state: state)
            SubjectDasboard(subjects: subjects)
        }
        .background(.primaryContainer)
    }
}


#Preview {
    let subjects = [
        Subject(name: "Matemáticas", teacher: "Prof. García", score: 8.5, completionPercentage: 75, color: "blue",  schedule:"Lunes 9am 11am"),
        Subject(name: "Historia", teacher: "Prof. López", score: 9.0, completionPercentage: 80, color: "green",schedule:"Lunes 9am 11am"),
        Subject(name: "Ciencias", teacher: "Prof. Martínez", score: 8.0, completionPercentage: 70, color: "yellow",schedule:"Lunes 9am 11am"),
        Subject(name: "Literatura", teacher: "Prof. Rodríguez", score: 9.5, completionPercentage: 85, color: "purple",schedule:"Lunes 9am 11am"),
        Subject(name: "Arte", teacher: "Prof. Sánchez", score: 8.8, completionPercentage: 78, color: "pink",schedule:"Lunes 9am 11am")
    ]
    MainScreen(state: DashboardState(pendingTasks: 5, completedTasks: 10, overdueTasks: 2), subjects: subjects)
}
