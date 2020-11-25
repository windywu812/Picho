//
//  HistoryViewMode.swift
//  Picho
//
//  Created by Windy on 16/11/20.
//

import UIKit

class HistoryViewModel {
    
    private var allHistoryData: [Int: [DailyIntake]] = [:]
    
    init() {
        fetchData()
//        setDummyData()
    }
    
    func fetchData() {
        CoreDataService.shared.getDailyIntake { [weak self] (intakes) in
            self?.allHistoryData = Dictionary(grouping: intakes, by: { ($0.date?.month ?? 0) })
        }
    }
    
    func getDataWeekofMonth(in month: Int) -> [Int?: [DailyIntake]] {
        /// Get data in one month
        let dataByMonth = allHistoryData[month]
        /// Get data in all weeks in one month
        let groupMyWeek = Dictionary(grouping: dataByMonth ?? [], by: { $0.date?.weekOfMonth })
        
        return groupMyWeek
    }
    
    // MARK: Dummy Data Sets
    private func setDummyData() {
                
        let foodNames = ["Ayam Goreng", "Nasi Ayam", "Ayam Geprek", "Ayam Bensu", "Nasi Uduk", "AW", "KFC", "Burger King", "McD"]
        
        for i in -90...90 {
            let random1 = foodNames.randomElement()!
            let random2 = foodNames.randomElement()!
            let random3 = foodNames.randomElement()!
            let random4 = foodNames.randomElement()!
            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: random1, name: random1, description: "FoodDescription", calorie: Double(Int.random(in: 0...113)), saturatedFat: Double(Int.random(in: 0...353)), sugars: Double(Int.random(in: 0...512)), date: Date().add(i), time: .breakfast)
            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: random2, name: random2, description: "FoodDescription", calorie: Double(Int.random(in: 0...541)), saturatedFat: Double(Int.random(in: 0...500)), sugars: Double(Int.random(in: 0...643)), date: Date().add(i), time: .lunch)
            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: random3, name: random3, description: "FoodDescription", calorie: Double(Int.random(in: 0...842)), saturatedFat: Double(Int.random(in: 0...500)), sugars: Double(Int.random(in: 0...533)), date: Date().add(i), time: .dinner)
            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: random4, name: random4, description: "FoodDescription", calorie: Double(Int.random(in: 0...200)), saturatedFat: Double(Int.random(in: 0...500)), sugars: Double(Int.random(in: 0...321)), date: Date().add(i), time: .snacks)
        }
    }
    
}
