import SwiftUI

enum AppTab: CaseIterable {
    case home, subjects, tasks, grades, aboutUs

    var title: String {
        switch self {
        case .home:    return "Home"
        case .subjects:  return "Subjects"
        case .tasks:  return "Tasks"
        case .grades: return "Grades"
        case .aboutUs: return "About us"
        }
    }

    var icon: String {
        switch self {
        case .home:    return "house"
        case .subjects:  return "book"
        case .tasks:  return "checkmark.circle"
        case .grades: return "chart.bar"
        case .aboutUs: return "person"
        }
    }
}