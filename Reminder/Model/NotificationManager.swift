//
//  NotificationManager.swift
//  Reminder
//
//  Created by lim jia le on 2021/9/20.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    func reloadLocalNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    
    func createLocalNotification(title: String, birthday: Date, completion: @escaping (Error?) -> Void) {
        var dateComponents = DateComponents()
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        let month = formatter.string(from: birthday)
        let DayFormatter = DateFormatter()
        DayFormatter.dateFormat = "dd"
        let day = formatter.string(from: birthday)
        dateComponents.hour = 00
        dateComponents.minute = 05
        dateComponents.month = Int(month)
        dateComponents.day = Int(day)
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .default
        notificationContent.body = "記得送上你的生日祝福喔！"
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func deleteLocalNotifications(identifiers: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
