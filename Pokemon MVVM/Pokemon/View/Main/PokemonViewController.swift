//
//  PokemonViewController.swift
//  Pokemon
//
//  Created by Siti Hafsah on 13/07/23.
//

import UIKit

class PokemonViewController: UIViewController {
    
    private let homeViewModel = HomeViewModel()
    
    
    var apiResult =  PokemonIndex(results: [PokemonEntry]())
//    var pokemonModel = [PokemonEntry]()
    var pokemonFilter: [PokemonEntry] = []
//    var pokemonSelected: PokemonEntry?
    var searchActive : Bool = false
    
    var viewModel = ViewModel()
    
    @IBOutlet weak var searchbarOutlet: UISearchBar!
    
    @IBOutlet weak var collectPokeOutlet: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbarOutlet.delegate = self
//        searchbarOutlet.text?.capitalized
        
        collectPokeOutlet.delegate = self
        collectPokeOutlet.dataSource = self
        collectPokeOutlet.collectionViewLayout = UICollectionViewFlowLayout()
        collectPokeOutlet.register(UINib(nibName: "PokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellPokemon")
        homeViewModel.homeViewModel = self
        homeViewModel.getApi()
        }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("pokeModelCount",pokemonModel.count)
//        viewModel.fetchApi()
//        viewModel.reloadCollection = {
//            DispatchQueue.main.async {
//                self.collectPokeOutlet.reloadData()
//            }
//        }
//    }
        
    }


extension PokemonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive == true {
            return pokemonFilter.count
        } else {
            return homeViewModel.pokemonModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectPokeOutlet.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPokemon", for: indexPath) as! PokemonCollectionViewCell
        
        if searchActive == true {
            cell.configure(data: pokemonFilter[indexPath.item])
        } else {
            cell.configure(data: homeViewModel.pokemonModel[indexPath.item])
        }
        
        cell.shadowDecorate()
        let imagePokemon = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPath.item + 1).png"
        
        if let imageUrl = URL(string: imagePokemon){
            DispatchQueue.global().async {
                if let imageData =  try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                    if collectionView.indexPath(for: cell) ==  indexPath {
                        cell.imagePokeOutlet.image = image
                    }
                    }
                }
            }
        }
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailUrl = homeViewModel.pokemonModel[indexPath.item].url
        
        guard let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        
        vc.configure(detailUrl: detailUrl)
        vc.detailUrl = detailUrl
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonFilter = []
        print("editTextStarted")
        if searchText == "" {
            searchActive = false
            pokemonFilter = homeViewModel.pokemonModel
            
        } else {
            searchActive = true
            for poke in homeViewModel.pokemonModel
            {
                if poke.name.lowercased().contains(searchText.lowercased())
                {
                    pokemonFilter.append(poke)
                }
            }
//            pokemonFilter = pokemonModel.filter({$0.name.contains(searchText)})
//            print(pokemonModel.filter({$0.name.contains(searchText)}))
        }
        collectPokeOutlet.reloadData()
    }
}

