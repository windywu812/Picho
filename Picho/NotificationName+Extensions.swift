//
//  NotificationName+Extensions.swift
//  Picho
//
//  Created by Wendy Kurniawan on 13/11/20.
//

import Foundation

extension Notification.Name {
    static var dateChanged: Notification.Name {
        return .init(NotificationKey.dateChangeKey)
    }
}
