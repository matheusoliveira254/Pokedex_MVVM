//
//  PokemonTableViewCell.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: PokemonServiceRequestImageViews!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    var viewModel: PokemonTableViewCellViewModel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = nil
        pokemonNameLabel.text = nil
        pokemonIDLabel.text = nil
    }
    
    
    private func fetchImage(with imageURL: String) {
        pokemonImageView.fetchImage(with: imageURL)
       
    }
}

extension PokemonTableViewCell: PokemonTableViewCellViewModelDelegate {
    func configure(with pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name
        pokemonIDLabel.text = "ID: \(pokemon.id)"
        pokemonImageView.fetchImage(with: pokemon.sprites.frontShiny)
        fetchImage(with: pokemon.sprites.frontShiny)
    }
}
