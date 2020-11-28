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
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
        fetchAllFood()
    }
    
    func fetchAllFood() {
        apiService.fetchApi(with: .getAllFood, response: [FoodDetail].self) { (result) in
            switch result {
            case .success(let response):
                self.allFood = response
            case .failure(let err):
                print(err.localizedDescription)
                self.allFood = []
            }
        }
    }
    
    func fetchSearch(keyword: String) {
        apiService.fetchApi(with: .searchFood(keyword), response: [FoodDetail].self) { (result) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}
