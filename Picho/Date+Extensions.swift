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
    
//    var year: Int {         return calender.component(.year, from: self)     }          var month: Int {         return calender.component(.month, from: self)     }          var week: Int {         return calender.component(.weekOfYear, from: self)     }          var weekAndYear: DateComponents {         return calender.dateComponents([.weekOfYear, .year], from: self)     }          var weekDay: Int {         return calender.component(.weekday, from: self)     }          var startOfDay: Date {         return calender.startOfDay(for: self)     }          var endOfDay: Date {         var component = DateComponents()         component.day = 1         component.second = -1                  return calender.date(byAdding: component, to: Date().startOfDay)!     }          func add(_ x: Int) -> Date {         let cal = Calendar.current                  return cal.date(byAdding: .day, value: x, to: Date())!     }
    
}
