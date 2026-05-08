import Foundation
import SwiftData

@Model
final class Task: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var description: String
    var dueDate: Date?
    var isDone: Bool
    
    // Relación con Subject
    var subject: Subject?
    
    init(name: String, description: String, dueDate: Date? = nil, 
         isDone: Bool = false, subject: Subject? = nil) {
        self.name = name
        self.description = description
        self.dueDate = dueDate
        self.isDone = isDone
        self.subject = subject
    }
}