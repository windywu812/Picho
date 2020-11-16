//
//  Array+Extensions.swift
//  iChol
//
//  Created by Windy on 04/11/20.
//

import Foundation

enum Nutrition {
    case calorie, sugar, satFat
}

extension Array {
    
    func convertToString() -> String {
        var container: String = ""
        
        self.forEach { (string) in
            container.append("\(string) \n")
        }
        
        return container
    }
    
    func getAverage(of nutrition: Nutrition) -> Double {
        let data = self as! [DailyIntake]
        
        var container: Double = 0.0
        
        switch nutrition {
        case .calorie:
            data.forEach { (daily) in
                container += daily.calorie
            }
        case .sugar:
            data.forEach { (daily) in
                container += daily.sugars
            }
        case .satFat:
            data.forEach { (daily) in
                container += daily.saturatedFat
            }
        }
        
        return data.count > 0 ? container / Double(data.count) : 0.0
    }
    
    func groupByTime(on time: EatTime) -> [DailyIntake] {
        let data = self as! [DailyIntake]
        return data.filter { $0.time == time.rawValue }
    }
    
    func groupByMax() -> [String?: [DailyIntake]] {
        let maximumCons = self.getMax()
        let group = self.groupById()
        
        return group.filter { maximumCons.keys.contains($0.key) }
    }
    
    func getMax() -> [String?: Int] {
        let data = self as! [DailyIntake]
        let group = Dictionary(grouping: data) { $0.foodId }.mapValues { $0.count }
        let greatest = group.filter { $0.value == group.values.max() }
        return greatest
    }
    
    func groupById() -> [String?: [DailyIntake]] {
        let data = self as! [DailyIntake]
        return Dictionary(grouping: data) { $0.foodId }
    }
    
}
