//
//  FoodResponse.swift
//  Picho
//
//  Created by Windy on 27/11/20.
//

import Foundation

struct FoodResponse: Decodable {
    let foods: [FoodDetail]
}

struct FoodDetail: Decodable {
    let foodId: Int
    let nameId: String
    let nameEn: String
    let serving: Double
    let calories: Double
    let calorieFromFat: Double
    let totalFat: Double
    let saturatedFat: Double
    let transFat: Double
    let cholesterol: Double
    let sodium: Double
    let totalCarbs: Double
    let fiber: Double
    let sugar: Double
    let protein: Double
    let vitaminA: Double
    let calcium: Double
    let vitaminC: Double
    let iron: Double
    
    private enum CodingKeys: String, CodingKey {
        case foodId
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
}
