//
//  FoodDetailViewModel.swift
//  Picho
//
//  Created by Windy on 27/11/20.
//

import Foundation

class FoodDetailViewModel {
    
    var labels: [[String]] = []
    
    init() {
        setupLabel()
    }
   
    private func setupLabel() {
        let sectionOneLabels = ["Calories", "Saturated Fat", "Sugars"]
        let sectionTwoLabels = ["Serving Size"]
        let sectionThreeLabels = ["Fat", "Calorie From Fat", "TransFat", "Cholesterol"]
        let sectionFourLabels = ["Carbohydrate", "Protein", "Fiber", "Sodium", "Calcium", "Iron"]
        let sectionFiveLabels = ["Vitamin A", "Vitamin B"]
        
        labels = [sectionOneLabels, sectionTwoLabels, sectionThreeLabels, sectionFourLabels, sectionFiveLabels]
    }
    
}
