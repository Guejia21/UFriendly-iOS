import Foundation
import SwiftData

@Model
final class Grade: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var value: Double
    var weight: Double
    var date: Date?
    
    // Relación con Subject
    var subject: Subject?
    
    init(name: String, value: Double, weight: Double, 
         date: Date? = nil, subject: Subject? = nil) {
        self.name = name
        self.value = value
        self.weight = weight
        self.date = date
        self.subject = subject
    }
}