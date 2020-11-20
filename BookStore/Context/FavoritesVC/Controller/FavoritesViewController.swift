//
//  FavoritesViewController.swift
//  BookStore
//
//  Created by amir on 20.11.2020.
//

import UIKit
import CoreData

class FavoritesViewController: BaseVC {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(cellClass: FavoriteTableViewCell.self)
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = UIColor.red
        }
    }
    
    // MARK: - Properties
    private var favoritesViewModel = FavoritesViewModel()
    private var disposal = Disposal()
    private var controller : NSFetchedResultsController<SBook>?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        bindUI()
        favoritesViewModel.fetchFavorites()
    }
    
    // MARK: - Private Method
    private func bindUI() {
        favoritesViewModel.state.observe { [weak self] (state) in
            guard let self = self else { return }
            switch state {
            case .success:
                self.updateUI()
            case .error(let err):
                self.handleAlertView(title: nil, message: err?.localizedDescription ?? "")
            default:
                break
            }
        }.add(to: &disposal)
    }
    

    private func updateUI() {
        favoritesViewModel.controller.delegate = self
        if favoritesViewModel.controller.fetchedObjects?.isEmpty ?? false {
            TableViewHelper.shared.EmptyMessage(message: "There is no favourites found.", viewController: self, tableView: tableView)
            self.pageTitle = "Favourites"
        } else {
            self.pageTitle = "Favourites (\(favoritesViewModel.controller.fetchedObjects?.count ?? 0))"
        }        
        tableView.reloadData()
    }

}

// MARK: - Table Delegate Datasource

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as! FavoriteTableViewCell
        if let sBook = favoritesViewModel.controller.fetchedObjects?[indexPath.row] {
            cell.sBookItemViewModel = SBookItemViewModel(book: sBook)
            cell.isSeparatorHidden = indexPath.row == favoritesViewModel.numberOfRow - 1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Coordinator.shared.requestNavigation(.book, data: favoritesViewModel.controller.object(at: indexPath), animated: true)        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (contextualAction, view, boolValue) in
            let item  = self.favoritesViewModel.controller.object(at:indexPath as IndexPath)
            
            view.tintColor = .red
            boolValue(true)
            context.delete(item)
            appDelegate.saveContext()
            self.favoritesViewModel.fetchFavorites()
        }
        deleteAction.backgroundColor = .systemRed
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}

/**
    NSFetched Results Controller Delegate

    - Parameter NSFetchedResultsControllerDelegate: SBook Result Controller

    - Todo: updated UI when class lifecycle is open such as UITabbarController

    - Author: amir daliri

    - Note: it's just for show experience Not Working now. if user change, removes, add, or updated book from the database, this method will call.
**/

// MARK: - NSFetchedResultsControllerDelegate
extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
                tableView.backgroundView = nil
                favoritesViewModel.fetchFavorites()
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! FavoriteTableViewCell
                if let sBook = favoritesViewModel.controller.fetchedObjects?[indexPath.row] {
                    cell.sBookItemViewModel = SBookItemViewModel(book: sBook)
                }
            }
            break
            
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        @unknown default:
            fatalError()
        }
    }
}
