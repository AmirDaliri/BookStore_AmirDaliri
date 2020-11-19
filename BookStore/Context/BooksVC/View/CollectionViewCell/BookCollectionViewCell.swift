//
//  BookCollectionViewCell.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import UIKit
import CoreData

class BookCollectionViewCell: UICollectionViewCell, UICollectionViewCellLoading {
    
    @IBOutlet private weak var bookImageView: UIImageView! {
        didSet {
            bookImageView.layer.cornerRadius = 8.0
            bookImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var bookTitleLabel: UILabel!
    @IBOutlet private weak var faveButton: UIButton!
    
    // MARK: - Properties
    
    var bookItemViewModel: BookItemViewModel = BookItemViewModel() {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Private Functions
    private func updateUI() {
        bookImageView.setImage(urlStr: bookItemViewModel.imageURL)
        bookTitleLabel.text = bookItemViewModel.title
        checkFavoriteCondition()
    }
    
    private func checkFavoriteCondition() {
        if bookItemViewModel.isFavedBook() {
            faveButton.setImage(#imageLiteral(resourceName: "ic_faved"), for: .normal)
        } else {
            faveButton.setImage(#imageLiteral(resourceName: "ic_fave"), for: .normal)
        }
    }
    
    private func removeItemFromTable() {
        let controller = CoreDataManager.shared.getSbookNSFetchedResultsController()
        if let items = controller.fetchedObjects,
           let book = items.first(where: {$0.id == bookItemViewModel.id}) {
            context.delete(book)
            appDelegate.saveContext()
            checkFavoriteCondition()
        }
    }
    
    // MARK: - IBAction
    @IBAction func faveButtonTapped(_ sender: UIButton) {
        if bookItemViewModel.isFavedBook() {
            removeItemFromTable()
        } else {
            bookItemViewModel.addToFavorite()
            checkFavoriteCondition()
        }
    }
}
