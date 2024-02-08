import UIKit
import UserNotifications

// MARK: CLASS:

final class NotificationManager {
    // MARK: SINGLETON:

    static let instance = NotificationManager()
    private init() {}

    // MARK: SET NOTIFICATION:

    func setNotification(message: String, id: Int, user: (String, String, String)) {
        // MARK: REQUEST FOR PRIVACY:

        let nc = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound]
        nc.requestAuthorization(options: options) { granted, _ in
            print("\(#function) Permission granted: \(granted)")
            guard granted else { return }
        }

        // MARK: CREATE NOTIFICATION:

        guard let date = convertDate(date: user.2) else { return }
        let content = UNMutableNotificationContent()
        content.body = "\(user.0) \(user.1)"
        content.title = NSLocalizedString("HB", comment: "")
        content.sound = UNNotificationSound.default
        var dateComponents = DateComponents()
        dateComponents.month = date.1
        dateComponents.day = date.2
        dateComponents.hour = 13
        dateComponents.minute = 45
        dateComponents.second = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        nc.add(request, withCompletionHandler: nil)
    }

    // MARK: - CONVERT DATE FROM STRING TO INT:

    private func convertDate(date: String) -> (Int, Int, Int)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let date = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            return (year, month, day)
        } else {
            return nil
        }
    }
}

// MARK: - EXTENSION: NSCOPING:

extension NotificationManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
