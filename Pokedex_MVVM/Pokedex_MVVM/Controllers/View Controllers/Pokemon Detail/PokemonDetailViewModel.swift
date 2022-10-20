//
//  PokemonDetailViewModel.swift
//  Pokedex_MVVM
//
//  Created by Matheus Oliveira on 10/20/22.
//

import UIKit

struct PokemonDetailViewModel {
    var pokemon: Pokemon
    var spriteImage: UIImage?
    
    init(pokemon: Pokemon, image: UIImage?) {
        self.pokemon = pokemon
        self.spriteImage = image
    }
}
