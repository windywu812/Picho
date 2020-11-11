//
//  Date+Extensions.swift
//  iChol
//
//  Created by Windy on 02/11/20.
//

import Foundation

extension Date {
    
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM yyyy"
        
        return formatter.string(from: self)
    }
    
    func startOfTheDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }

    func endDate(of date: Date) -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        return Calendar.current.date(byAdding: components, to: Date().startOfTheDay())!
    }
    
    func nextDate() -> Date {
        var components = DateComponents()
        components.day = 1
        
        return Calendar.current.date(byAdding: components, to: Date())!
    }
    
    func toShortFormat(of date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
}
