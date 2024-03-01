//
//  FoodDetailViewModel.swift
//  Picho
//
//  Created by Windy on 27/11/20.
//

import Foundation

class FoodDetailViewModel {
    var labels: [[String]] = []
    var units: [[String]] = []

    init() {
        setupLabel()
        setupUnit()
    }

    private func setupLabel() {
        let sectionOneLabels = [NSLocalizedString("Calories", comment: ""), NSLocalizedString("Saturated Fat", comment: ""), NSLocalizedString("Sugars", comment: "")]
        let sectionTwoLabels = [NSLocalizedString("Serving Size", comment: "")]
        let sectionThreeLabels = [NSLocalizedString("Fat", comment: ""), NSLocalizedString("Calorie From Fat", comment: ""), NSLocalizedString("Trans Fat", comment: ""), NSLocalizedString("Cholesterol", comment: "")]
        let sectionFourLabels = [NSLocalizedString("Carbohydrate", comment: ""), NSLocalizedString("Protein", comment: ""), NSLocalizedString("Fiber", comment: ""), NSLocalizedString("Sodium", comment: ""), NSLocalizedString("Calcium", comment: ""), NSLocalizedString("Iron", comment: "")]
        let sectionFiveLabels = ["Vitamin A", "Vitamin B"]

        labels = [sectionOneLabels, sectionTwoLabels, sectionThreeLabels, sectionFourLabels, sectionFiveLabels]
    }

    private func setupUnit() {
        let sectionOneUnits = ["kCal", "g", "g"]
        let sectionTwoUnits = ["g"]
        let sectionThreeUnits = ["g", "kCal", "g", "mg"]
        let sectionFourUnits = ["g", "g", "g", "mg", "%", "%"]
        let sectionFiveUnits = ["%", "%"]

        units = [sectionOneUnits, sectionTwoUnits, sectionThreeUnits, sectionFourUnits, sectionFiveUnits]
    }
}
