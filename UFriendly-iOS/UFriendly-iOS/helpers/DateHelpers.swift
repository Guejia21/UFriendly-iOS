import Foundation

func isToday(date: Date?) -> Bool {
    guard let date = date else { return false }
    return Calendar.current.isDateInToday(date)
}

func isExpired(date: Date?) -> Bool {
    guard let date = date else { return false }
    return date < Date()
}

func formatDate(_ date: Date?) -> String {
    guard let date = date else { return "Sin fecha" }
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter.string(from: date)
}

func convertMillisToDate(_ millis: Double?) -> Date? {
    guard let millis = millis else { return nil }
    return Date(timeIntervalSince1970: millis / 1000)
}
