//
//  Date+Extensions.swift
//  iChol
//
//  Created by Windy on 02/11/20.
//

import Foundation

extension Date {
    
    func startOfTheDay() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        return calendar.startOfDay(for: self)
    }

    func endDate() -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        return calendar.date(byAdding: components, to: self.startOfTheDay())!
    }
    
    func nextDate() -> Date {
        var components = DateComponents()
        components.day = 1
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        return calendar.date(byAdding: components, to: Date())!
    }
    
    func toShortFormat(of date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    func changeToString() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        return dateFormat.string(from: self)
    }
    
}
