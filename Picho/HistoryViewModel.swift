//
//  HistoryViewMode.swift
//  Picho
//
//  Created by Windy on 16/11/20.
//

import UIKit

class HistoryViewModel {
    
    var allHistoryData: [Int: [DailyIntake]] = [:]
    
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
        for i in -90...90 {
            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: "FoodId2", name: "FoodName", description: "FoodDescription", calorie: Double(Int.random(in: 0...300)), saturatedFat: Double(Int.random(in: 0...300)), sugars: Double(Int.random(in: 0...300)), date: Date().add(i), time: .breakfast)
            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: "FoodId2", name: "FoodName", description: "FoodDescription", calorie: Double(Int.random(in: 0...300)), saturatedFat: Double(Int.random(in: 0...300)), sugars: Double(Int.random(in: 0...300)), date: Date().add(i), time: .lunch)
            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: "FoodId2", name: "FoodName", description: "FoodDescription", calorie: Double(Int.random(in: 0...300)), saturatedFat: Double(Int.random(in: 0...300)), sugars: Double(Int.random(in: 0...300)), date: Date().add(i), time: .dinner)
            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: "FoodId2", name: "FoodName", description: "FoodDescription", calorie: Double(Int.random(in: 0...300)), saturatedFat: Double(Int.random(in: 0...300)), sugars: Double(Int.random(in: 0...300)), date: Date().add(i), time: .snacks)
        }
    }
    
}
