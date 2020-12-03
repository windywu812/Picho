//
//  NotificationService.swift
//  Picho
//
//  Created by Wendy Kurniawan on 13/11/20.
//

import Foundation

class NotificationService {
    static let shared = NotificationService()

    func post(with key: String = NotificationKey.dailyIntakeKey) {
        let name = Notification.Name(rawValue: key)
        NotificationCenter.default.post(name: name, object: true)
    }
}
