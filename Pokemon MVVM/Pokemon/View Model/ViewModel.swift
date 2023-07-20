//
//  ViewModel.swift
//  Pokemon
//
//  Created by Siti Hafsah on 18/07/23.
//

import Foundation
import UIKit

class ViewModel {
    
    var models: [SavePokemonModel] = []
    var instance = CoreDataManage()
    var coredataManage = CoreDataManage()
    var detail: PokemonDetail?
    var modelCount: Int {
        return models.count
    }
    
    var deleteRows: (([IndexPath]) -> Void)?
    
    var saveViewModel: SavePokemonModel?
    
    
    func modelCell(_ cell: PokemonSaveTableViewCell, at indexPath: IndexPath) {
        let models = models[indexPath.item]
        cell.configure(with: models)
    }
    
    func saveData(){
        instance.retrive {
            savePokemon in self.models = savePokemon
            print("save pokemon model")
        }
    }
    
    func deleteData(indexPath: IndexPath){
        print(models.count)
        let pokemon = models[indexPath.row]
        instance.delete(pokemon.speciesPokemon) {
            DispatchQueue.main.async { [weak self] in
                self?.models.remove(at: indexPath.row)
                guard let unwrappedDeleteRows = self?.deleteRows else { return }
                unwrappedDeleteRows([indexPath])
//                self?.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    
    
    
    
    
    
    

    
    //
//    var apiResult =  PokemonIndex(results: [PokemonEntry]())
//    var pokemonModel = [PokemonEntry]()
//    var pokemonFilter: [PokemonEntry] = []
//    var pokemonSelected: PokemonEntry?
//    var searchActive : Bool = false
//    var updateUI: ((_ newDataToDisplay: String?) -> Void)?
//    var reloadCollection : (() -> ())?
    
//    func fetchApi() {
//        PokeApi().getData() {  PokemonIndex in
//            self.pokemonModel.append(contentsOf: PokemonIndex)
////            self.pokeModel(PokemonIndex)
//            self.reloadCollection?()
//            for pokemon in self.pokemonModel {
//                print(pokemon.name)
//            }
//        }
//    }
    
//    func createCell(datas: [PokemonEntry]){
//        self.pokemonModel = datas
//
//    }
    
    
    
}

struct CellViewModel {
    
}
