//
//  Date+Extensions.swift
//  iChol
//
//  Created by Windy on 02/11/20.
//

import Foundation

extension Date {
    
    func getBreakfast() -> DateComponents {
        var dateComponent = DateComponents()
        dateComponent.hour = 8
        dateComponent.minute = 0
        dateComponent.calendar = Calendar.current
        
        return dateComponent
    }
    
    func getLunch() -> DateComponents {
        var dateComponent = DateComponents()
        dateComponent.hour = 12
        dateComponent.minute = 0
        dateComponent.calendar = Calendar.current
        
        return dateComponent
    }
    
    func getDinner() -> DateComponents {
        var dateComponent = DateComponents()
        dateComponent.hour = 19
        dateComponent.minute = 0
        dateComponent.calendar = Calendar.current
        
        return dateComponent
    }
    
    func changeToString() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        return dateFormat.string(from: self)
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
    
    func getComponent() -> DateComponents {
        return Calendar.current.dateComponents([.hour, .minute], from: self)
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
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var weekOfMonth: Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var component = DateComponents()
        component.day = 1
        component.second = -1
        
        return Calendar.current.date(byAdding: component, to: Date().startOfDay)!
    }
    
    func add(_ x: Int) -> Date {
        let cal = Calendar.current
        
        return cal.date(byAdding: .day, value: x, to: Date())!
    }
    
    func convertIntToMonth(month: Int) -> String {
        switch month {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return ""
        }
    }
    
}
