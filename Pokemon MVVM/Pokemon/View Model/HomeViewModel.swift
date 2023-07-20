//
//  HomeViewModel.swift
//  Pokemon
//
//  Created by Siti Hafsah on 20/07/23.
//

import Foundation


class HomeViewModel{
    var homeViewModel: PokemonViewController?
    var pokemonModel = [PokemonEntry]()
    
    func getApi(){
        guard let unwrappedVc = homeViewModel else {return}
        PokeApi().getData() {  PokemonIndex in
            self.pokemonModel.append(contentsOf: PokemonIndex)
            unwrappedVc.collectPokeOutlet.reloadData()
            for pokemon in self.pokemonModel {
                print(pokemon.name)
            }

        }
    }
}
