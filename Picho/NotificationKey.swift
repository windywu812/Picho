//
//  NotificationKey.swift
//  Picho
//
//  Created by Wendy Kurniawan on 12/11/20.
//

import Foundation

struct NotificationKey {
    static let dailyIntakeKey = "\(Bundle.main.bundleIdentifier ?? "").dailyintake"
    static let dateChangeKey = "\(Bundle.main.bundleIdentifier ?? "").dateChanged"
    static let favoriteKey = "\(Bundle.main.bundleIdentifier ?? "").favorite"
}
