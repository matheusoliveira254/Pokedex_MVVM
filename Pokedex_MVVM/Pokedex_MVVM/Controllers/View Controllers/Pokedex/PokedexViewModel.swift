//
//  PokedexViewModel.swift
//  Pokedex_MVVM
//
//  Created by Matheus Oliveira on 10/19/22.
//

import Foundation

protocol PokedexViewModelDelegate: PokedexTableViewController {
    func updateViews()
}

class PokedexViewModel {
    
    var pokedex: Pokedex?
    var pokedexEntries: [PokemonResults] = []
    weak var delegate: PokedexViewModelDelegate?
    private let pokedexService: PokedexFetchServiceable
    
    //Dependency Injection
    init(delegate: PokedexViewModelDelegate, pokedexService: PokedexFetchServiceable = PokedexFetchService()) {
        self.delegate = delegate
        self.pokedexService = pokedexService
        fetchPokedex()
    }
    
    func fetchPokedex() {
        pokedexService.fetchPokedex(endPoint: .pokedex) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error fetching the Pokedex", error.errorDescription!)
            case .success(let pokedexData):
                self?.pokedex = pokedexData
                self?.pokedexEntries = pokedexData.results
                DispatchQueue.main.async {
                    self?.delegate?.updateViews()
                }
            }
        }
    }
}//End of class
