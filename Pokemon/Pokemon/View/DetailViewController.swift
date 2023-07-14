//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Siti Hafsah on 13/07/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonDescView: UIView!{
        didSet{
            pokemonDescView
                .roundCorners(corners: [.topLeft, .topRight], radius: 20)
        }
    }
    
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descBtn: UIButton!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var pokemonNameView: UILabel!
    @IBOutlet weak var pokemonName2View: UILabel!
    @IBOutlet weak var pokemonHeightView: UILabel!
    @IBOutlet weak var pokemonWeightView: UILabel!
    
    var detail: PokemonDetail?
    var detailUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.trailingConstraint.constant = self.view.frame.width
        loadDetail()
    }
    private var isBottomSheetShown = false
    
    @IBAction func descBtnPokemon(_ sender: Any)
    {
        if (isBottomSheetShown)
        {
            // hide the bottom sheet
            UIView.animate(withDuration: 0.1, animations: {
                
                self.heightConstraint.constant = 300
                self.view.layoutIfNeeded()
            }) { (status) in
                self.isBottomSheetShown = false
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.heightConstraint.constant = 0
                    self.trailingConstraint.constant = self.view.frame.width
                    self.view.layoutIfNeeded()
                }) { (status) in
                    // not to be used
                }
                // completion code
            }
        }
        else{
            // show the bottom sheet
            
            UIView.animate(withDuration: 0.1, animations: {
                self.heightConstraint.constant = 420
                self.trailingConstraint.constant = 10
                self.view.layoutIfNeeded()
            }) { (status) in
                // completion code
                self.isBottomSheetShown = true
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.heightConstraint.constant = 400
                    
                    self.view.layoutIfNeeded()
                }) { (status) in
                    
                }
            }
        }
        
    }
    
    private func loadDetail() {
        guard let unwrappedDetailUrl = detailUrl else { return }
        guard let url = URL(string: unwrappedDetailUrl) else { return }
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
//                print(error?.localizedDescription)
                return
            }
            do {
//                print("do")
                self?.detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                self?.loadImage()
//
                DispatchQueue.main.async { [weak self] in
                    self?.pokemonNameView.text = self?.detail?.name
                    self?.pokemonName2View.text = self?.detail?.species.name
                    self?.pokemonHeightView.text = String(self?.detail?.height ?? 0)
                    self?.pokemonWeightView.text = String(self?.detail?.weight ?? 0)
                }
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
        
        
    }

    
    private func loadImage() {
        guard let unwrappedDetail = detail else {
            return
            
        }
        let imageUrl = unwrappedDetail.sprites.frontDefault
        guard let url = URL(string: imageUrl) else { return }
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.pokemonImageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }

    func configure(detailUrl: String) {
        self.detailUrl = detailUrl
    }

}
