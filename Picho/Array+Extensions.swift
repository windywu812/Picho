//
//  Array+Extensions.swift
//  iChol
//
//  Created by Windy on 04/11/20.
//

import Foundation

extension Array {
    
    func convertToString() -> String {
        var container: String = ""
        
        self.forEach { (string) in
            container.append("\(string) \n")
        }
        
        return container
    }
    
    func getAverageCalorie() -> Double {
        let data = self as! [DailyIntake]
        
        var container: Double = 0.0
        data.forEach { (daily) in
            container += daily.calorie
        }
        
        return data.count > 0 ? container / Double(data.count) : 0.0
    }
    
    func getAverageSugar() -> Double {
        let data = self as! [DailyIntake]
        
        var container: Double = 0.0
        data.forEach { (daily) in
            container += daily.sugars
        }
        
        return data.count > 0 ? container / Double(data.count) : 0.0
    }
    
    func getAverageSatFat() -> Double {
        let data = self as! [DailyIntake]
        
        var container: Double = 0.0
        data.forEach { (daily) in
            container += daily.saturatedFat
        }
        
        return data.count > 0 ? container / Double(data.count) : 0.0
    }
    
}
