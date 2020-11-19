//
//  BookViewModel.swift
//  BookStore
//
//  Created by amir on 19.11.2020.
//

import Foundation
import UIKit

class BookViewModel: BaseVM {
    
    private var model: Book
    
    init(model: Book = Book()) {
        self.model = model
    }

    var imageLink: String {
        return model.volumeInfo?.imageLinks?.thumbnail ?? ""
    }
    
    var name: String {
        var name = ""
        name += model.volumeInfo?.title ?? ""
        if let subtitle = model.volumeInfo?.subtitle {
            name += "\n\n\(subtitle)"
        }
        return name
    }
    
    var authors: String {
        if let authorsValue = model.volumeInfo?.authors, authorsValue.count > 0 {
            return authorsValue.joined(separator: ", ")
        } else {
            return "-"
        }
    }
    
    var publishedDate: String {
        return model.volumeInfo?.publishedDate ?? ""
    }
    
    var descriptionAttr: NSAttributedString {
        return justifyLabel(str: model.volumeInfo?.descriptionValue ?? "")
    }
    
    var isPurchasesEnable: Bool {
        return (model.saleInfo?.buyLink ?? "").isEmpty
    }
    
    var buyLink: String {
        return model.saleInfo?.buyLink ?? ""
    }
    
    private func justifyLabel(str: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        paragraphStyle.lineSpacing = 5.0
        let attributedString = NSAttributedString(string: str, attributes: [ NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.baselineOffset: NSNumber(value: 0) ])
        return attributedString
    }

}
