//
//  StringOptional+Extensions.swift
//  Picho
//
//  Created by Windy on 11/11/20.
//

import UIKit

extension Optional where Wrapped == String {
    func convertToDouble() -> Double {
        return Double(self ?? "0.0") ?? 0.0
    }
}

extension String {
    func convertIntToMonth() -> Int {
        switch self {
        case "January":
            return 1
        case "February":
            return 2
        case "March":
            return 3
        case "April":
            return 4
        case "May":
            return 5
        case "June":
            return 6
        case "July":
            return 7
        case "August":
            return 8
        case "September":
            return 9
        case "October":
            return 10
        case "November":
            return 11
        case "December":
            return 12
        default:
            return 0
        }
    }
}
