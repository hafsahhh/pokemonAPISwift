//
//  EditPokemonViewController.swift
//  Pokemon
//
//  Created by Siti Hafsah on 17/07/23.
//

import UIKit

class EditPokemonViewController: UIViewController {
    
    var editViewModel = EditViewModel()
    var namePokemonEdit: String = ""
    var speciesPokemonEdit: String = ""
    var heightPokemonEdit: Int16 = 0
    var weightPokemonEdit: Int16 = 0
    
    @IBOutlet weak var nameEditView: UITextField!
    @IBOutlet weak var speciesEditView: UITextField!
    @IBOutlet weak var heightEditView: UITextField!
    @IBOutlet weak var weightEditView: UITextField!
    
    @IBOutlet weak var updateBtnView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        editViewModel.editViewController = self
        
        editViewModel.showData(
            namePokemonEdit: namePokemonEdit,
            speciesPokemonEdit: speciesPokemonEdit,
            heightPokemonEdit: heightPokemonEdit,
            weightPokemonEdit: weightPokemonEdit)
        
    }

    
    @IBAction func namePokeAct(_ sender: Any) {
        
    }
    
    
    @IBAction func updateBtnPokemon(_ sender: UIButton) {
        editViewModel.updateData(namePokemonEdit: namePokemonEdit)
        print("update pokemon")
//        let updateBtnCtrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokemonSaveUIViewController") as! PokemonSaveUIViewController
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}

