//
//  MainViewController.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        MainRequest.shared.getBooks(index: 1) { (err, books) in
            print(books)
        }
    }
}
