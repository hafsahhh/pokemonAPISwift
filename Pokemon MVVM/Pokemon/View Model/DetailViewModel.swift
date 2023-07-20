//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Siti Hafsah on 20/07/23.
//

import Foundation

class DetailViewModel {
    
    var pokemonModel = [PokemonEntry]()
    var detail: PokemonDetail?
    var coredataManage = CoreDataManage()
    
    func saveCoreData(){
        guard let imagePokemon = self.detail?.sprites.frontDefault else {return}
        guard let namePokemon = self.detail?.name else {return}
        guard let speciesPokemon = self.detail?.species.name else {return}
        guard let heightPokemon = self.detail?.height else {return}
        guard let weightPokemon = self.detail?.weight else {return}
        
        print("saveClicked")
        coredataManage.create(imagePokemon, namePokemon, speciesPokemon, heightPokemon, weightPokemon)
        coredataManage.rettri()
    }
    
    func saveBtnPoke(encodedImage: String){
//        guard let imagePokemon = self.detail?.sprites.frontDefault else {return}
        guard let namePokemon = self.detail?.name else {return}
        guard let speciesPokemon = self.detail?.species.name else {return}
        guard let heightPokemon = self.detail?.height else {return}
        guard let weightPokemon = self.detail?.weight else {return}
        
//        print("saveClicked" )
        coredataManage.create(encodedImage, namePokemon, speciesPokemon, heightPokemon, weightPokemon)
    }
    

}
