//
//  PokemonServiceRequestImageView.swift
//  Pokedex_MVVM
//
//  Created by Matheus Oliveira on 10/19/22.
//

import UIKit

class PokemonServiceRequestImageViews: UIImageView {
    private let service = APIService()
    
    func fetchImage(with urlString: String) {
        guard let requestURL = URL(string: urlString) else {return}
        let request = URLRequest(url: requestURL)
        service.perform(request) { [weak self] result in
            switch result {
            case .failure:
                print("Error fetching Image" )
                self?.setDefaultImage()
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {return}
                DispatchQueue.main.async {
                    self?.contentMode = .scaleToFill
                    self?.image = image
                }
            }
        }
    }
    func setDefaultImage() {
        contentMode = .scaleAspectFit
        self.image = UIImage(systemName: "ticket")
    }
}

