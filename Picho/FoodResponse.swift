//
//  FoodResponse.swift
//  Picho
//
//  Created by Windy on 27/11/20.
//

import Foundation

struct FoodDetail: Decodable {
    let foodId: Int
    let nameId: String
    let nameEn: String
    var serving: Double
    var calories: Double
    var calorieFromFat: Double
    var totalFat: Double
    var saturatedFat: Double
    var transFat: Double
    var cholesterol: Double
    var sodium: Double
    var totalCarbs: Double
    var fiber: Double
    var sugar: Double
    var protein: Double
    var vitaminA: Double
    var calcium: Double
    var vitaminC: Double
    var iron: Double
    
    private enum CodingKeys: String, CodingKey {
        case foodId = "id"
        case nameId = "name_id"
        case nameEn = "name_en"
        case calorieFromFat = "calorie_from_fat"
        case totalFat = "total_fat"
        case saturatedFat = "saturated_fat"
        case transFat = "trans_fat"
        case totalCarbs = "total_carbs"
        case vitaminA = "vitamin_a"
        case vitaminC = "vitamin_c"
        case serving, calories, cholesterol,
             sodium, fiber, sugar,
             protein, calcium, iron
    }
    
    mutating func changeData(newData: FoodDetail) {
        serving = newData.serving
        calories = newData.calories
        calorieFromFat = newData.calorieFromFat
        totalFat = newData.totalFat
        saturatedFat = newData.saturatedFat
        transFat = newData.transFat
        cholesterol = newData.cholesterol
        sodium = newData.sodium
        totalCarbs = newData.totalCarbs
        fiber = newData.fiber
        sugar = newData.sugar
        protein = newData.protein
        vitaminA = newData.vitaminA
        calcium = newData.calcium
        vitaminC = newData.vitaminC
        iron = newData.iron
    }
    
}
