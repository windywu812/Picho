//
//  Endpoints.swift
//  Picho
//
//  Created by Windy on 27/11/20.
//

import Foundation

struct BaseAPI {
    static let baseURL = ""
    static let apiKey = ""
}

enum Endpoints {
    
    case getAllFood
    case getDetail(Int)
    case searchFood(String)
    
    var url: String {
        switch self {
        case .getAllFood:
            return "\(BaseAPI.baseURL)"
        case .getDetail(let idFood):
            return "\(BaseAPI.baseURL)\(idFood)"
        case .searchFood(let keyword):
            return "\(BaseAPI.baseURL)\(keyword)"
        }
    }
}
