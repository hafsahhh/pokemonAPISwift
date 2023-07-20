//
//  PokemonSave.swift
//  Pokemon
//
//  Created by Siti Hafsah on 17/07/23.
//

import Foundation
import UIKit

struct SavePokemonModel {
    var imagePokemon: String!
    var namePokemon: String = ""
    var speciesPokemon: String = ""
    var heightPokemon: Int16 = 0
    var weightPokemon: Int16 = 0
    let accessoryType : UITableViewCell.AccessoryType
}

