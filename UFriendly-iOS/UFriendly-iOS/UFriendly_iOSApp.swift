import SwiftUI
import SwiftData

@main
struct UFriendly_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Subject.self, Task.self, ClassSchedule.self, Grade.self])
    }
}
