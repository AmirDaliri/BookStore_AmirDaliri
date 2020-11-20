//
//  CoreDataManager.swift
//  BookStore
//
//  Created by amir on 20.11.2020.
//

import Foundation
import CoreData
import Kingfisher

class CoreDataManager: NSObject {
    static let shared = CoreDataManager()
    
    func getSbookNSFetchedResultsController() -> NSFetchedResultsController<SBook> {
        let fetchRequest :NSFetchRequest<SBook> = SBook.fetchRequest()
        
        let datasort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [datasort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do{
            try controller.performFetch()
        }
        catch{
            let error = error as NSError
            print(error.debugDescription)
        }
        return controller
    }
    
    func addToFavorite(book: Book) {
        let bookTable = SBook(context: context)
        var name = ""
        name += book.volumeInfo?.title ?? ""
        if let subtitle = book.volumeInfo?.subtitle {
            name += "\n\n\(subtitle)"
        }
        bookTable.name = name
        var authors = ""
        if let authorsValue = book.volumeInfo?.authors, authorsValue.count > 0 {
            authors = authorsValue.joined(separator: ", ")
        } else {
            authors = "-"
        }
        bookTable.authors = authors
        bookTable.publishedDate = book.volumeInfo?.publishedDate ?? ""
        bookTable.descriptionValue = book.volumeInfo?.descriptionValue ?? ""
        bookTable.isPurchasesEnable = (book.saleInfo?.buyLink ?? "").isEmpty
        bookTable.buyLink = book.saleInfo?.buyLink ?? ""
        bookTable.id = book.id ?? ""

        if let url = URL.init(string: book.volumeInfo?.imageLinks?.thumbnail ?? "") {
            let resource = ImageResource(downloadURL: url)
            KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    if let data = value.image.pngData() {
                        bookTable.img = data
                    }
                case .failure(_):
                    break
                }
            }
        }
        appDelegate.saveContext()
    }
}
