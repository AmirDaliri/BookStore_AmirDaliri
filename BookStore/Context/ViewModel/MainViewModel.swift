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

    init(model: Books = Books()) {
        responseModel = model
    }
    
    func getBooks(index: Int) {
        MainRequest.shared.getBooks(index: index) { (err, response) in            
            guard let books = response else {
                self.handlePopup(error: err)
                self.setState(.error(err))
                return
            }
            self.responseModel = books
            self.setState(.success)
        }
    }
}
