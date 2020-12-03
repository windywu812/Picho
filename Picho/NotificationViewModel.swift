//
//  NotificationViewModel.swift
//  Picho
//
//  Created by Windy on 19/11/20.
//

import UserNotifications

class NotificationViewModel {
    var notifications: [Notif] = []

    init() {
        fetchData()
    }

    private func fetchData() {
        CoreDataService.shared.fetchNotificationData { notifs in
            self.notifications = notifs
        }
    }

    func addNotification(id: String, title: String, body: String, time: DateComponents, isOn: Bool, timeLabel: String) {
        CoreDataService.shared.addNotification(
            id: id,
            isOn: isOn,
            timeLabel:
            timeLabel
        )
        NotificationCenterServices.setupNotification(
            uuid: id,
            title: title,
            body: body,
            time: time,
            isOn: isOn
        )
    }

    func requestPermission() {
        NotificationCenterServices.requestPermission()
    }
}
