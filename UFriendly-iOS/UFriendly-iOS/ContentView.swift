//
//  ContentView.swift
//  UFriendly-iOS
//
//  Created by MAC15 on 6/05/26.
//

import SwiftUI

struct ContentView: View {
    @Query private var subjects: [Subject]
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var context
    let pendingTasks: Int = tasks.filter { !$0.isDone }.count
    let completedTasks: Int = tasks.filter { $0.isDone }.count
    let overdueTasks: Int = tasks.filter { !$0.isDone && ($0.dueDate ?? Date()) < Date() }.count
    
    let dashboardState: DashboardState = DashboardState(pendingTasks: pendingTasks, completedTasks: completedTasks, overdueTasks: overdueTasks)
    var body: some View {
        MainScreen(state:dashboardState, subjects: subjects)
    }
}

#Preview {
    ContentView()
}
