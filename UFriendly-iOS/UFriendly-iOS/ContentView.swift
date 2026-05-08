//
//  ContentView.swift
//  UFriendly-iOS
//
//  Created by MAC15 on 6/05/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var subjects: [Subject]
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var context
    var pendingTasks: Int{
        tasks.filter { !$0.isDone }.count
    }
    var completedTasks: Int{
        tasks.filter { $0.isDone }.count
    }
    var overdueTasks: Int{
        tasks.filter { !$0.isDone && ($0.dueDate ?? Date()) < Date() }.count
    }
    var dashboardState: DashboardState{
        DashboardState(pendingTasks: pendingTasks, completedTasks: completedTasks, overdueTasks: overdueTasks)
    }
    var body: some View {
        MainScreen(state:dashboardState, subjects: subjects)
    }
}
#Preview {
    ContentView()
        .modelContainer(for: [Subject.self, Task.self], inMemory: true)
}
