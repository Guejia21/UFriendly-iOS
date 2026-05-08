import SwiftUI

struct ContentAreaView: View {
    let selectedTab: AppTab

    var body: some View {
        Group {
            switch selectedTab {
            case .home:    HomeView()
            case .subjects: SubjectsView()
            case .tasks:  TasksView()
            case .grades: GradesView()
            case .aboutUs: AboutUsView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGroupedBackground))
        .transition(.opacity) // animación suave al cambiar de tab
        .animation(.easeInOut(duration: 0.2), value: selectedTab)
    }
}