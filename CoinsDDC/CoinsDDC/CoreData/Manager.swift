//
//  Manager.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import CoreData

class CoreDataManager : ObservableObject, Observable{

    static var shared = CoreDataManager()
    
    var favCoins:[Coin]{
        if let array = self.fetchItems(){
            return array
        }
        return []
    }

// conteiner do core data
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoinModel")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Erro ao carregar o core data: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

// função para salvar o contexto
    func saveContext() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        do {
            try context.save()
            print("Salvou")
        } catch {
            let nserror = error as NSError
            fatalError("Erro ao salvar o contexto: \(nserror), \(nserror.userInfo)")
        }
    }
}


//Funções para manipular dados do CoreData
extension CoreDataManager{
    
    // adiciona a moeda
    func addCoin(name: String, favorite: Bool, currency : Currency){
        let coin = Coin(context: CoreDataManager.shared.persistentContainer.viewContext)
        coin.name = name
        coin.favorite = favorite
        coin.currency = currency.rawValue
        let fethced = fetchItems()
        
        saveContext()
        
    }
    
//    deleta a moeda
    func deleteCoin(coin : Coin){
        let context = persistentContainer.viewContext
        context.delete(coin)
        saveContext()
    }
    
    //Fetch da moeda
    func fetchItems() -> [Coin]?{
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request : NSFetchRequest<Coin> = NSFetchRequest(entityName: "Coin")
        
        do{
            let result : [Coin] = try context.fetch(request)
            return result
        }catch{
                print("Erro fetch in core data: \(error)")
        }
        return nil
    }
}

