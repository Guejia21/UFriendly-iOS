import Foundation

struct Subject: Identifiable{
    let id = UUID()
    let name: String
    let teacher: String
    let score: Double
    let completionPercentage: Int
    let color: String
    let schedule: String
}
