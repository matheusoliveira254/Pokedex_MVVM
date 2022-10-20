//
//  PokedexTableViewController.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    private var viewModel: PokedexViewModel!
    private var pokedexService = PokedexFetchService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = PokedexViewModel(delegate: self)
        viewModel.fetchPokedex()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.pokedexEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        
        cell.viewModel = PokemonTableViewCellViewModel(delegate: cell, pokedex: viewModel.pokedexEntries[indexPath.row])
        
        return cell
    }
    
    //MARK: - Pagination
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let lastPokedexIndex = viewModel.pokedexEntries.count - 1
        guard let pokedex = viewModel.pokedex, let nextURL = URL(string: viewModel.pokedex?.next ?? "") else {return}

        if indexPath.row == lastPokedexIndex {
            pokedexService.fetchPokedex(endPoint: .nextPage(nextURL)) { [weak self] result in
                switch result {
                case .success(let pokedex):
                    self?.viewModel.pokedex = pokedex
                    self?.viewModel.pokedexEntries.append(contentsOf: pokedex.results)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("There was an error!", error.errorDescription!)
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPokemonDetails",
           let destinationVC = segue.destination as? PokemonDetailViewController,
              let cell = sender as? PokemonTableViewCell,
        let pokemon = cell.viewModel.pokemon else {return}
        let pokemonSprite = cell.pokemonImageView.image
               
        destinationVC.viewModel = PokemonDetailViewModel(pokemon: pokemon, image: pokemonSprite)
    }
}

extension PokedexTableViewController: PokedexViewModelDelegate {
    func updateViews() {
        tableView.reloadData()
    }
}
