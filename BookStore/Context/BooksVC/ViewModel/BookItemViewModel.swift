//
//  BookItemViewModel.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Foundation
import CoreData

class BookItemViewModel: BaseVM {
    private var book: Book

    init(book: Book = Book()) {
        self.book = book
    }

    var imageURL: String {
        return book.volumeInfo?.imageLinks?.smallThumbnail ?? ""
    }
    
    var title: String {
        return book.volumeInfo?.title ?? ""
    }
    
    var id: String {
        return book.id ?? ""
    }

    // MARK: - CoreData Method
    func addToFavorite() {
        CoreDataManager.shared.addToFavorite(book: book)
    }
    
    func isFavedBook() -> Bool {
        let controller = CoreDataManager.shared.getSbookNSFetchedResultsController()
        if let items = controller.fetchedObjects {
            for i in items {
                if book.id == i.id {
                    return true
                }
            }
        }
        return false
    }
}
