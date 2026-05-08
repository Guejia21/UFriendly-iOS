import Foundation
import SwiftData

@Model
final class ClassSchedule: Identifiable {
    @Attribute(.unique) var id: UUID = UUID() 
    var day: String
    var startHour: String
    var endHour: String
    var subject: Subject?
    
    init(day: String, startHour: String, endHour: String, subject: Subject? = nil) {
        self.day = day
        self.startHour = startHour
        self.endHour = endHour
        self.subject = subject
    }
}