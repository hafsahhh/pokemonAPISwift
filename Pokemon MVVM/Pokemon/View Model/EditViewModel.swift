//
//  EditViewModel.swift
//  Pokemon
//
//  Created by Siti Hafsah on 20/07/23.
//

import Foundation
class EditViewModel {
    
    var editViewController: EditPokemonViewController?
    var coredataManage = CoreDataManage()

    
    func showData(namePokemonEdit: String,speciesPokemonEdit: String,heightPokemonEdit: Int16, weightPokemonEdit: Int16){
        guard let unwrappedVc = editViewController else {return}
        unwrappedVc.nameEditView.text = namePokemonEdit
        unwrappedVc.speciesEditView.text = speciesPokemonEdit
        unwrappedVc.heightEditView.text = "\(heightPokemonEdit)"
        unwrappedVc.weightEditView.text = "\(weightPokemonEdit)"
        print("cucu\(namePokemonEdit)")
    }
    
    func updateData(namePokemonEdit: String){
        guard let unwrappedVc = editViewController else {return}
        guard let nameUpdate = unwrappedVc.nameEditView.text else {return}
        coredataManage.update(namePokemon: namePokemonEdit, with: nameUpdate, nameDataCoreData: "namePokemon")
    }
    
}
