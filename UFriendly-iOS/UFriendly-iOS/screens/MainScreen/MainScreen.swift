import SwiftUI

struct MainScreen: View {
    let state: DashboardState
    let subjects: [Subject]
    let onViewAllTasks: () -> Void
    let onViewAllSubjects: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                WelcomeDashboard(state: state, onViewAllClick: onViewAllTasks)
                SubjectDasboard(subjects: subjects, onViewAllClick: onViewAllSubjects)
            }
        }
        .background(.primaryContainer)
    }
}

#Preview {
    let subjects = [
        Subject(name: "Matematicas", teacher: "Prof. Garcia", score: 8.5, completionPercentage: 75, color: "blue"),
        Subject(name: "Historia", teacher: "Prof. Lopez", score: 9.0, completionPercentage: 80, color: "green"),
    ]
    MainScreen(
        state: DashboardState(pendingTasks: 5, completedTasks: 10, overdueTasks: 2),
        subjects: subjects,
        onViewAllTasks: {},
        onViewAllSubjects: {}
    )
}
