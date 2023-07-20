//
//  CoreDataManage.swift
//  Pokemon
//
//  Created by Siti Hafsah on 17/07/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManage {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    //CORE DATA
    
    //MARK: CREATE DATA IN CORE DATA
    func create (_ imagePokemon: String, _ namePokemon: String, _ speciesPokemon: String, _ heightPokemon : Int16, _ weightPokemon: Int16 ){

        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}

        let userEntity = NSEntityDescription.entity(forEntityName: "CoreDataPokemon", in: managedContext)

        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        insert.setValue(imagePokemon, forKey: "imagePokemon")
        insert.setValue(namePokemon, forKey: "namePokemon")
        insert.setValue(speciesPokemon, forKey: "speciesPokemon")
        insert.setValue(heightPokemon, forKey: "heightPokemon")
        insert.setValue(weightPokemon, forKey: "weightPokemon")

        do {
            try managedContext.save()
            print("save data into core data")
        }catch let err{
            print("failed to save data", err)
        }
    }

    @discardableResult func rettri() ->[SavePokemonModel] {
        var pokemon = [SavePokemonModel]()
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataPokemon")

        do {
            let result = try managedContext?.fetch(fetchRequest) as! [NSManagedObject]

            result.forEach{ pokemonList in
                pokemon.append(
                    SavePokemonModel(
                        imagePokemon: pokemonList.value(forKey: "imagePokemon") as? String,
                        namePokemon: pokemonList.value(forKey: "namePokemon") as! String,
                        speciesPokemon: pokemonList.value(forKey: "speciesPokemon") as! String,
                        heightPokemon: pokemonList.value(forKey: "heightPokemon") as! Int16,
                        weightPokemon: pokemonList.value(forKey: "weightPokemon") as! Int16, accessoryType: UITableViewCell.AccessoryType.none

                        
                    )
                )
                print("ada gak?\(pokemonList as Any)")
            }
        }  catch let error {
            print("failed to fetch data", error)
        }
        return pokemon
    }
    
    
    //MARK: SAVE DATA IN CORE DATA
    func retrive(completion: @escaping ([SavePokemonModel]) -> Void) {
        
        var pokemon = [SavePokemonModel]()
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataPokemon")
        
        do {
            guard let result = try managedContext?.fetch(fetchRequest) as? [NSManagedObject] else { return }
            
            result.forEach{ pokemonList in
                pokemon.append(
                    SavePokemonModel(
                        imagePokemon: pokemonList.value(forKey: "imagePokemon") as! String,
                        namePokemon: pokemonList.value(forKey: "namePokemon") as! String,
                        speciesPokemon: pokemonList.value(forKey: "speciesPokemon") as! String,
                        heightPokemon: pokemonList.value(forKey: "heightPokemon") as! Int16,
                        weightPokemon: pokemonList.value(forKey: "weightPokemon") as! Int16, accessoryType: UITableViewCell.AccessoryType.none

                    )
                )
                print(pokemonList as Any)
            }
            completion(pokemon)
        }  catch let error {
            print("failed to fetch data", error)
//            completion([])
        }
    }
    
    func update( namePokemon: String, with newName: String, nameDataCoreData: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "CoreDataPokemon")
            let modifiedPredicateFormat = "\(nameDataCoreData) = %@"
            fetchRequest.predicate = NSPredicate(format:  modifiedPredicateFormat, namePokemon )

        do {
          let fetchedResults = try managedContext.fetch(fetchRequest)

          if let pokemon = fetchedResults.first {
            pokemon.setValue(newName, forKey: "namePokemon")
//              pokemon.setValue(newSpecies, forKey: "speciesPokemon")

            do {
              try managedContext.save()
              print("Data updated successfully")
            } catch{
              print("Failed to update data: (error), (error.userInfo)", error)
            }
          }
        } catch {
          print("Fetch error: (error), (error.userInfo)", error)
        }

      }
//    //MARK: UPDATE DATA IN CORE DATA
//    func update (_ namePokemon: String, with newName: String,
//                 _ speciesPokemon: String, with newSpecies: String,
//                 _ heightPokemon : Int16, with newHeight: Int16,
//                 _ weightPokemon: Int16, with newWeight: Int16 ){
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
//
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CoreDataPokemon")
//        fetchRequest.predicate = NSPredicate(format: "namePokemon = %@", namePokemon)// mengganti berdasarkan nama jadi harus ada nama yang sudah ke record di core data
//        do{
//            let result = try managedContext.fetch(fetchRequest)
//
//            for index in 0..<result.count{
//                let dataToUpdate = result[index] as! NSManagedObject
//                dataToUpdate.setValue(namePokemon, forKey: "newName")
//                dataToUpdate.setValue(speciesPokemon, forKey: "newSpecies")
//                dataToUpdate.setValue(heightPokemon, forKey: "newHeight")
//                dataToUpdate.setValue(weightPokemon, forKey: "newWeight")
//
//                try managedContext.save()
//                print("Update Pokemon", dataToUpdate)
//            }
//            self.retrive { pokemom in
//                print ("update", pokemom)
//            }
//        } catch let error{
//            print("unable to save data", error)
//        }
//    }
    
    //MARK: DELETE DATA IN CORE DATA
    func delete(_ speciesPokemon: String, completion: @escaping () -> Void) {

        //managed context
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return }

        //fetch data to edit data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CoreDataPokemon")
        fetchRequest.predicate = NSPredicate(format: "speciesPokemon = %@", speciesPokemon)

        do {
            let result = try managedContext.fetch(fetchRequest)

            for index in 0..<result.count {
                let dataToDelete = result[index] as! NSManagedObject
                managedContext.delete(dataToDelete)
            }
            try managedContext.save()
            completion()
//            retrieve()
            
        } catch let error {
            print("Unable to delete data", error)
        }
    }
    
}

