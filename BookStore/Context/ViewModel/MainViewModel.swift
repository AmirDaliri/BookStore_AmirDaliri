//
//  MainViewModel.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Foundation
import UIKit

class MainViewModel: BaseVM {
    
    private var responseModel: Books
    private var index = 0
    private var bookList: [Book] = []
    
    init(model: Books = Books()) {
        responseModel = model
    }
    
    func getBooks() {
        setState(.loading)
        MainRequest.shared.getBooks(index: index) { (err, response) in            
            guard let model = response, let books = model.items else {
                self.handlePopup(error: err)
                self.setState(.error(err))
                return
            }
            self.responseModel = model
            self.bookList.append(contentsOf: books)
            self.index += 1
            self.setState(.success)
        }
    }

    var numberOfRows: Int {
        return bookList.count
    }
    
    func bookAtIndex(_ index: Int) -> BookItemViewModel? {
        return BookItemViewModel(book: bookList[index])
    }
    
    var isEmpty: Bool {
        return !(bookList.count > 0)
    }
}
