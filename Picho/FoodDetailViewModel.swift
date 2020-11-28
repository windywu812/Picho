//
//  FoodDetailViewModel.swift
//  Picho
//
//  Created by Windy on 27/11/20.
//

import Foundation

class FoodDetailViewModel {
    
    var food: FoodDetail?
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService(), idFood: Int) {
        self.apiService = apiService
        fetchDetail(idFood: idFood)
    }
    
    func fetchDetail(idFood: Int) {
        apiService.fetchApi(with: .getDetail(idFood), response: FoodDetail.self) { (result) in
            switch result {
            case .success(let response):
                self.food = response
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}
