//
//  PokedexFetchService.swift
//  Pokedex_MVVM
//
//  Created by Matheus Oliveira on 10/19/22.
//

import Foundation

protocol PokedexFetchServiceable {
    func fetchPokedex(endPoint: PokemonEndPoint, completion: @escaping (Result<Pokedex, NetworkError>) -> Void)
}

struct PokedexFetchService: PokedexFetchServiceable {
    
    private let apiService = APIService()
    
    func fetchPokedex(endPoint: PokemonEndPoint, completion: @escaping (Result<Pokedex, NetworkError>) -> Void) {
        
        guard let url = endPoint.url else {completion(.failure(.badURL)); return}
        let request = URLRequest(url: url)
        
        apiService.perform(request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(.requestError(error)))
            case .success(let data):
                do {
                    let pokedex = try JSONDecoder().decode(Pokedex.self, from: data)
                    completion(.success(pokedex))
                } catch {
                    completion(.failure(.errorDecoding))
                }
            }
        }
    }
}//End of class
