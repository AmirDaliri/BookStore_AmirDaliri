//
//  BookItemViewModel.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Foundation

class BookItemViewModel: BaseVM {
    private var book: Book

    init(book: Book = Book()) {
        self.book = book
    }

    var imageURL: String {
        book.volumeInfo?.imageLinks?.thumbnail ?? ""
    }
}
