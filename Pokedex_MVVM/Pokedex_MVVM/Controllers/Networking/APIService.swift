//
//  NetworkingController.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

struct APIService {
    
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {completion(.failure(.requestError(error))); return}
            
            if let response = response as? HTTPURLResponse {print("Completed with response of", response.statusCode)}
            
            guard let data else {completion(.failure(.noData)); return}
            completion(.success(data))
        }.resume()
    }
}// End of struct
