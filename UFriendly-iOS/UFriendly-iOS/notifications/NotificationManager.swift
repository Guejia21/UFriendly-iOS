import UserNotifications
import Foundation

struct NotificationManager {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
    }

    static func createChannel() {
        let category = UNNotificationCategory(
            identifier: "task_reminders",
            actions: [],
            intentIdentifiers: [],
            options: .customDismissAction
        )
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }

    static func scheduleReminder(taskId: UUID, taskName: String, dueDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Task due soon!"
        content.body = "\"\(taskName)\" is about to expire"
        content.sound = .default
        content.categoryIdentifier = "task_reminders"

        let fireDate = dueDate.addingTimeInterval(-12 * 3600)
        guard fireDate > Date() else { return }

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(
            identifier: "reminder_\(taskId.uuidString)",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    static func cancelReminder(taskId: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ["reminder_\(taskId.uuidString)"]
        )
    }
}
