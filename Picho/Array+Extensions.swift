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
        
        return container / Double(data.count)
    }
    
    func getAverageSugar() -> Double {
        let data = self as! [DailyIntake]
        
        var container: Double = 0.0
        data.forEach { (daily) in
            container += daily.sugars
        }
        
        return container
    }
    
    func getAverageSatFat() -> Double {
        let data = self as! [DailyIntake]
        
        var container: Double = 0.0
        data.forEach { (daily) in
            container += daily.saturatedFat
        }
        return container
    }
    
}
