//
//  FoodSearchViewModel.swift
//  Picho
//
//  Created by Windy on 27/11/20.
//

import Foundation

class FoodSearchViewModel {
    @Published var allFood: [FoodDetail] = []
    @Published var searchFood: [FoodDetail] = []

    init() {
        fetchAllFood()
    }

    func fetchAllFood() {
        APIService.fetchApi(with: .getAllFood, response: [FoodDetail].self) { result in
            switch result {
            case let .success(response):
                self.allFood = response
            case let .failure(err):
                print(err.localizedDescription)
                self.allFood = []
            }
        }
    }

    func fetchSearch(keyword: String) {
        APIService.fetchApi(with: .searchFood(keyword), response: [FoodDetail].self) { result in
            switch result {
            case let .success(response):
                print(response)
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}
