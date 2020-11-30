//
//  Endpoints.swift
//  Picho
//
//  Created by Windy on 27/11/20.
//

import Foundation

struct BaseAPI {
    static let baseURL = "https://picho.web.id/"
    static let apiKey = "YhQJTCpuwI27JSlcSTZ7pNBiOT2MC7GJ"
}

enum Endpoints {
    
    case getAllFood
    case getDetail(Int)
    case searchFood(String)
    
    var url: String {
        switch self {
        case .getAllFood:
            return "\(BaseAPI.baseURL)\(BaseAPI.apiKey)"
        case .getDetail(let idFood):
            return "\(BaseAPI.baseURL)\(BaseAPI.apiKey)/\(idFood)/food"
        case .searchFood(let keyword):
            return "\(BaseAPI.baseURL)\(BaseAPI.apiKey)/search?q=\(keyword)"
        }
    }
}
