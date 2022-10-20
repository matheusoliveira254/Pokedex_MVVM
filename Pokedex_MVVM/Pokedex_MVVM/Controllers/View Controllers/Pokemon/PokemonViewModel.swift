//
//  PokemonViewModel.swift
//  Pokedex_MVVM
//
//  Created by Matheus Oliveira on 10/20/22.
//

import Foundation

protocol PokemonTableViewCellViewModelDelegate: PokemonTableViewCell {
    func configure(with pokemon: Pokemon)
}

class PokemonTableViewCellViewModel {
    
    weak var delegate: PokemonTableViewCellViewModelDelegate?
    var pokemon: Pokemon?
    var pokedex: PokemonResults
    private let pokemonService: PokemonFetchServiceable
    
    init(delegate: PokemonTableViewCellViewModelDelegate, pokedex: PokemonResults, pokemonService: PokemonFetchServiceable = PokemonFetchService()) {
        self.delegate = delegate
        self.pokedex = pokedex
        self.pokemonService = pokemonService
        fetchPokemon()
    }
    
    func fetchPokemon() {
        pokemonService.fetchPokemon(endPoint: .pokemon(pokedex.name)) { [weak self] result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self?.pokemon = pokemon
                    self?.delegate?.configure(with: pokemon)
                }
            case .failure(let error):
                print("Error", error.errorDescription!)
            }
        }
    }
}//End of class
