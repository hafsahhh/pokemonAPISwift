//
//  PokemonSaveUIViewController.swift
//  Pokemon
//
//  Created by Siti Hafsah on 17/07/23.
//

import UIKit

class PokemonSaveUIViewController: UIViewController{
    
//    var models: [SavePokemonModel] = []
//    var instance = CoreDataManage()
//    var detail: PokemonDetail?
//    var detailUrl: String?
//    let appDelegate = UIApplication.shared.delegate as? AppDelegate
//    var coredataManage = CoreDataManage()
//    var pokemonModel: SavePokemonModel?
//    var callEditPokemon: (()->())?
    
    private var viewModel: ViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        viewModel.saveData()
    
        // Subscribe callback
        viewModel.deleteRows = { [weak self] indexPaths in
            self?.tableView.deleteRows(at: indexPaths, with: .left)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokemonSaveTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonSaveTableViewCell")
        tableView.frame =  view.bounds
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        viewModel.saveData()
        print(self.viewModel.modelCount)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    // MARK: - handleMoveToTrash
    func handleMoveToTrash(indexPath: IndexPath) {
        viewModel.deleteData(indexPath: indexPath)
//        self.tableView.deleteRows(at: [indexPath], with: .fade)
        print("Moved to trash")
    }
    
    
    // MARK: - trailingSwipeActionsConfigurationForRowAt
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive,
                                       title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.handleMoveToTrash(indexPath: indexPath)
            completionHandler(true)
        }
        trash.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [trash])

        return configuration
    }
    
    
}




extension PokemonSaveUIViewController : UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.modelCount
    }
    
    
    // MARK: - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"PokemonSaveTableViewCell" , for: indexPath) as? PokemonSaveTableViewCell else {
            return UITableViewCell()
        }
        viewModel.modelCell(cell, at: indexPath)
        return cell
    }
    
    
    // MARK: - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let editBtnCtrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditPokemonViewController") as! EditPokemonViewController
//        editBtnCtrl.navigationItem.hidesBackButton = true

        let pokemon = viewModel.models[indexPath.row]
        print("helo\(pokemon.namePokemon)")
        editBtnCtrl.namePokemonEdit = pokemon.namePokemon
        editBtnCtrl.speciesPokemonEdit = pokemon.speciesPokemon
        editBtnCtrl.heightPokemonEdit = pokemon.heightPokemon
        editBtnCtrl.weightPokemonEdit = pokemon.weightPokemon
        self.navigationController?.pushViewController(editBtnCtrl, animated: true)
    }
}

