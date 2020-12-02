//
//  NotificationCenterService.swift
//  Picho
//
//  Created by Windy on 15/11/20.
//

import UserNotifications

class NotificationCenterServices {
    
    static func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
            if let error = error {
                print(error)
            } else {
                print(granted)
            }
        }
    }
    
    static func setupNotification(uuid: String, title: String, body: String, time: DateComponents, isOn: Bool) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound]) { (granted,error) in}
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
        
        let request = UNNotificationRequest(identifier: uuid, content: notificationContent, trigger: trigger)
        
        if isOn {
            center.removeDeliveredNotifications(withIdentifiers: [uuid])
            center.removePendingNotificationRequests(withIdentifiers: [uuid])
            center.add(request) { error in
                guard let error = error else {
                    print("Added")
                    return
                }
                print(error.localizedDescription)
            }
        } else {
            center.removeDeliveredNotifications(withIdentifiers: [uuid])
            center.removePendingNotificationRequests(withIdentifiers: [uuid])
        }
    }
    
}
