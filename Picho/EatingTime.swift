//
//  FoodTime.swift
//  iChol
//
//  Created by Windy on 02/11/20.
//

import Foundation

struct EatingTime {
    static let eatingTime: [EatTime] = [.breakfast, .lunch, .dinner, .snacks]
}

enum EatTime: String {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case dinner = "dinner"
    case snacks = "snacks"
}
