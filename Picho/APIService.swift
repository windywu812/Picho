//
//  APIService.swift
//  Picho
//
//  Created by Windy on 27/11/20.
//

import Foundation

class APIService {
    
    static func fetchApi<T: Decodable>(with endpoint: Endpoints, response: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        
        guard let urlString = URL(string: endpoint.url) else { return }
        
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if error != nil { print(error!.localizedDescription)}
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch let err {
                completion(.failure(err))
            }
            
        }.resume()
    }
    
}
