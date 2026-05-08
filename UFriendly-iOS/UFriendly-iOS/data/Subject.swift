import Foundation
import SwiftData

@Model
final class Subject: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var teacher: String
    var score: Double
    var completionPercentage: Int
    var color: String
    
    // Relaciones
    @Relationship(deleteRule: .cascade, inverse: \ClassSchedule.subject) 
    var schedules: [ClassSchedule] = []
    
    @Relationship(deleteRule: .cascade, inverse: \Task.subject) 
    var tasks: [Task] = []
    
    @Relationship(deleteRule: .cascade, inverse: \Grade.subject) 
    var grades: [Grade] = []
    
    init(name: String, teacher: String, score: Double, 
         completionPercentage: Int, color: String) {
        self.name = name
        self.teacher = teacher
        self.score = score
        self.completionPercentage = completionPercentage
        self.color = color
    }
}