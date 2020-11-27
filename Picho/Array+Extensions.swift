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
    
    func getHistory() -> [History] {
        let data = self as! [DailyIntake]
        let group = data.groupByMax()
        let groupTimes = data.getMax()
        var histories: [History] = []
        for (id, intakes) in group {
            if let id = id {
                let name = intakes.getName(by: id)
                let eatTimes = groupTimes[id] ?? 0
                let totalCalorie = intakes.getSum(of: .calorie)
                let totalSatFat = intakes.getSum(of: .satFat)
                let totalSugar = intakes.getSum(of: .sugar)
                histories.append(History(foodId: id, foodName: name, eatTimes: eatTimes, totalCalorie: totalCalorie, totalSatFat: totalSatFat, totalSugar: totalSugar))
            }
        }
        return histories
    }
    
    func getSum(of nutrition: Nutrition) -> Double {
        let data = self as! [DailyIntake]
        
        var container: Double = 0.0
        
        switch nutrition {
        case .calorie:
            container = data.reduce(0, { $0 + $1.calorie })
        case .sugar:
            container = data.reduce(0, { $0 + $1.sugars })
        case .satFat:
            container = data.reduce(0, { $0 + $1.saturatedFat })
        }
        
        return container 
    }
    
    func getAverage(of nutrition: Nutrition) -> Double {
        let data = self as! [DailyIntake]
        
        var container: Double = 0.0
        
        switch nutrition {
        case .calorie:
            container = data.reduce(0, { $0 + $1.calorie })
        case .sugar:
            container = data.reduce(0, { $0 + $1.sugars })
        case .satFat:
            container = data.reduce(0, { $0 + $1.saturatedFat })
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
    
    func getName(by id: String) -> String {
        let data = self as! [DailyIntake]
        let filtered = data.filter { $0.foodId == id }
        return filtered.first?.name ?? ""
    }
    
}
