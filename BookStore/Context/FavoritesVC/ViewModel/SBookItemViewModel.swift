//
//  SBookItemViewModel.swift
//  BookStore
//
//  Created by amir on 20.11.2020.
//

import Foundation
import UIKit

class SBookItemViewModel: BaseVM {
    private var book: SBook

    init(book: SBook = SBook()) {
        self.book = book
    }

    var imageData: Data? {
        return book.img
    }
    
    var title: String {
        return book.name ?? ""
    }
    
    var id: String {
        return book.id ?? ""
    }
    
    var authors: String {
        return book.authors ?? ""
    }
    
    var publishedDate: String {
        return book.publishedDate ?? ""
    }
    
    var descriptionAttr: NSAttributedString {
        return justifyLabel(str: book.descriptionValue ?? "")
    }
    
    var isPurchasesEnable: Bool {
        return book.isPurchasesEnable
    }
    
    var buyLink: String {
        return book.buyLink ?? ""
    }
    
    private func justifyLabel(str: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        paragraphStyle.lineSpacing = 5.0
        let attributedString = NSAttributedString(string: str, attributes: [ NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.baselineOffset: NSNumber(value: 0) ])
        return attributedString
    }
}
