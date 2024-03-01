//
//  JournalViewModel.swift
//  Picho
//
//  Created by Windy on 19/11/20.
//

import Combine
import Foundation
import HealthKit

class JournalViewModel {
    @Published var calorieLeft: Double = 0.0
    @Published var satFatLeft: Double = 0.0
    @Published var sugarLeft: Double = 0.0
    @Published var totalStep: Double = 0.0
    @Published var totalWater: Double = 0.0

    var calorieIntake: Double = 0.0
    var saturatedFatIntake: Double = 0.0
    var sugarIntake: Double = 0.0

    init() {
        countCalorie()
        fetchData()
    }

    func fetchData() {
        if HealthKitService.shared.checkAuthorization() {
            HealthKitService.shared.fetchData(
                type: .dietaryEnergyConsumed,
                unit: .smallCalorie()
            ) { totalCal in
                self.calorieLeft = self.calorieIntake - totalCal
            }
            HealthKitService.shared.fetchData(type: .dietaryFatSaturated, unit: .gram()) { totalFat in
                self.satFatLeft = self.saturatedFatIntake - totalFat
            }
            HealthKitService.shared.fetchData(type: .dietarySugar, unit: .gram()) { totalSugar in
                self.sugarLeft = self.sugarIntake - totalSugar
            }
            HealthKitService.shared.fetchData(type: .stepCount, unit: .count()) { step in
                self.totalStep = step
            }
            CoreDataService.shared.getWater { waters in
                self.totalWater = Double(waters.count)
            }
        } else {
            CoreDataService.shared.getDailyIntake { intakes in
                let calorie = intakes.map { $0.calorie }
                let satFat = intakes.map { $0.saturatedFat }
                let sugar = intakes.map { $0.sugars }

                self.calorieLeft = self.calorieIntake - calorie.reduce(0.0, +)
                self.satFatLeft = self.saturatedFatIntake - satFat.reduce(0.0, +)
                self.sugarLeft = self.sugarIntake - sugar.reduce(0.0, +)
            }
        }
    }

    private func countCalorie() {
        let age = Double(UserDefaultService.age ?? String(0))
        let weight = Double(UserDefaultService.weight ?? String(0))
        let height = Double(UserDefaultService.height ?? String(0))

        if UserDefaultService.gender == "Male" {
            calorieIntake = (10 * weight!) + (6.25 * height!) - (5 * age!) + 5
            saturatedFatIntake = (calorieIntake / 10) / 9
            sugarIntake = (calorieIntake / 10) / 4
        } else {
            calorieIntake = (10 * weight!) + (6.25 * height!) - (5 * age!) - 161
            saturatedFatIntake = (calorieIntake / 10) / 9
            sugarIntake = (calorieIntake / 10) / 4
        }
    }
}
