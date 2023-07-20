//
//  PokemonSaveTableViewCell.swift
//  Pokemon
//
//  Created by Siti Hafsah on 17/07/23.
//

import UIKit
import SDWebImage

class PokemonSaveTableViewCell: UITableViewCell {
    @IBOutlet weak var imageSave: UIImageView!
    
    @IBOutlet weak var nameSaveView: UILabel!
    
    @IBOutlet weak var speciesSaveView: UILabel!
    
    @IBOutlet weak var heightSaveView: UILabel!
    
    @IBOutlet weak var weightSaveView: UILabel!
    
    @IBOutlet weak var editSaveView: UIButton!
    
    
//    var detail: PokemonDetail?
//    var detailUrl: String?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var coredataManage = CoreDataManage()
    var pokemonModel: SavePokemonModel?
    let ImageView = UIImageView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setImageWithPlugin(url: String) {

        let urlImage = URL(string: url)
        imageSave.sd_setImage(with: urlImage)
    }
    
    func configure(with pokemon: SavePokemonModel) {
        if let convertedImage = pokemon.imagePokemon.imageFromBase64 {
            imageSave.image = convertedImage
            
        }
        
        print("convertedImage is nil \(pokemon.imagePokemon.imageFromBase64 == nil)")
        
        nameSaveView.text = pokemon.namePokemon
        speciesSaveView.text = pokemon.speciesPokemon
        heightSaveView.text = "\(pokemon.heightPokemon)"
        weightSaveView.text = "\(pokemon.weightPokemon)"
    }
    
    
    func edit(with pokemon: SavePokemonModel){
        
    }
    
}
