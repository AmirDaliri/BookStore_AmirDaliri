//
//  FavoritesViewModel.swift
//  BookStore
//
//  Created by amir on 20.11.2020.
//

import Foundation
import CoreData

class FavoritesViewModel: BaseVM {
    
    var controller : NSFetchedResultsController<SBook>

    init(model: NSFetchedResultsController<SBook> = NSFetchedResultsController<SBook>()) {
        self.controller = model
    }

    //MARK: - coreData
    
    func fetchFavorites() {
        setState(.loading)
        let fetchRequest :NSFetchRequest<SBook> = SBook.fetchRequest()
        let datasort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [datasort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.controller = controller
        do{
            try controller.performFetch()
        }
        catch{
            setState(.error(nil))
        }
        setState(.success)
    }
    
    var numberOfRow: Int {
        return controller.fetchedObjects?.count ?? 0
    }
    
    func getItem(at indexPath: IndexPath) -> SBook? {
        return controller.fetchedObjects?[indexPath.row]
    }
}
