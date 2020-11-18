//
//  BookCollectionViewCell.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import UIKit

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
    }

    @IBAction func faveButtonTapped(_ sender: UIButton) {
        // TODO:  call delegate
    }
}
