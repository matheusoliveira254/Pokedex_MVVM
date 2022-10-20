//
//  PokemonServiceDataCell.swift
//  Pokedex_MVVM
//
//  Created by Matheus Oliveira on 10/19/22.
//

import Foundation

extension URL {
    static let pokemonBaseURL = URL(string: "https://pokeapi.co/api/v2/")
}
//Pokemon endpoint case pokemon can be used for searching if needed in the future
enum PokemonEndPoint {
    case pokedex
    case pokemon(String)
    
    var url: URL? {
        guard var baseURL = URL.pokemonBaseURL else {return nil}
        baseURL.appendPathComponent("pokemon")
        switch self {
        case .pokedex:
            return baseURL
        case .pokemon(let pokemon):
            baseURL.appendPathComponent(pokemon)
            return baseURL
        }
    }
}
