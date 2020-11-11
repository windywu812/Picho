//
//  NetworkService.swift
//  iChol
//
//  Created by Wendy Kurniawan on 03/11/20.
//

import Foundation

enum ServiceError: Error {
    case noResult
}

class NetworkService {
    
    private let client = FatSecretClient()
    static let shared = NetworkService()
    
    func searchFood(keyword: String, completion: @escaping (Result<[SearchedFood], Error>) -> Void) {
        client.searchFood(name: keyword) { result in
            switch result {
            case .success(let search):
                completion(.success(search.foods))
            case .failure(let error):
                completion(.failure(ServiceError.noResult))
                print(error.localizedDescription)
            }
        }
    }
    
    func getFood(id: String, completion: @escaping (Result<Food, Error>) -> Void) {
        client.getFood(id: id) { food in
            if ((food.servings?.isEmpty) == nil) {
                completion(.failure(ServiceError.noResult))
            } else {
                completion(.success(food))
            }
        }
    }
    
}
