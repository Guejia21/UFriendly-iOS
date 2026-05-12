import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var subjects: [Subject]
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var context

    @State private var selectedTab = 0
    @State private var showAddSubject = false
    @State private var showAddTask = false
    @State private var showAddGrade = false

    var pendingTasks: Int {
        tasks.filter { !$0.isDone }.count
    }

    var completedTasks: Int {
        tasks.filter { $0.isDone }.count
    }

    var overdueTasks: Int {
        tasks.filter { !$0.isDone && ($0.dueDate ?? Date()) < Date() }.count
    }

    var dashboardState: DashboardState {
        DashboardState(pendingTasks: pendingTasks, completedTasks: completedTasks, overdueTasks: overdueTasks)
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    MainScreen(
                        state: dashboardState,
                        subjects: subjects,
                        onViewAllTasks: { selectedTab = 2 },
                        onViewAllSubjects: { selectedTab = 1 }
                    )
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

                NavigationStack {
                    SubjectScreen()
                }
                .tabItem {
                    Label("Subjects", systemImage: "book.fill")
                }
                .tag(1)

                NavigationStack {
                    TaskScreen()
                }
                .tabItem {
                    Label("Tasks", systemImage: "checkmark.circle")
                }
                .tag(2)

                NavigationStack {
                    GradesScreen()
                }
                .tabItem {
                    Label("Grades", systemImage: "star.fill")
                }
                .tag(3)

                NavigationStack {
                    AboutUsScreen()
                }
                .tabItem {
                    Label("About", systemImage: "person.3.fill")
                }
                .tag(4)
            }

            FloatingFabMenu(
                onAddSubject: { showAddSubject = true },
                onAddTask: { showAddTask = true },
                onAddGrade: { showAddGrade = true }
            )
        }
        .sheet(isPresented: $showAddSubject) {
            NavigationStack { AddSubjectScreen() }
        }
        .sheet(isPresented: $showAddTask) {
            NavigationStack { AddTaskScreen() }
        }
        .sheet(isPresented: $showAddGrade) {
            NavigationStack { AddGradeScreen() }
        }
    }
}
