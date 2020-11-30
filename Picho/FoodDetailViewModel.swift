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
        let sectionOneLabels = ["Calories", "Saturated Fat", "Sugars"]
        let sectionTwoLabels = ["Serving Size"]
        let sectionThreeLabels = ["Fat", "Calorie From Fat", "TransFat", "Cholesterol"]
        let sectionFourLabels = ["Carbohydrate", "Protein", "Fiber", "Sodium", "Calcium", "Iron"]
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
