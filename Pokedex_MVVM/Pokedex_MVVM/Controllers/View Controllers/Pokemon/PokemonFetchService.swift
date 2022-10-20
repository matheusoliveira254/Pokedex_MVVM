//
//  FetchPokemonService.swift
//  Pokedex_MVVM
//
//  Created by Matheus Oliveira on 10/20/22.
//

import Foundation

protocol PokemonFetchServiceable {
    func fetchPokemon(endPoint: PokemonEndPoint, completion: @escaping (Result<Pokemon, NetworkError>) -> Void)
}

struct PokemonFetchService: PokemonFetchServiceable {
    
    private let apiService = APIService()
    
    func fetchPokemon(endPoint: PokemonEndPoint, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        guard let url = endPoint.url else {completion(.failure(.badURL)); return}
        let request = URLRequest(url: url)
        
        apiService.perform(request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(.requestError(error)))
            case .success(let data):
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    completion(.failure(.errorDecoding))
                }
            }
        }
    }
}//End of class
