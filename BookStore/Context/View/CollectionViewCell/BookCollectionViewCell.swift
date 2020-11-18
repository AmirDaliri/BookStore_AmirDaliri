//
//  BookCollectionViewCell.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell, UICollectionViewCellLoading {

    @IBOutlet private weak var bookImageView: UIImageView!
    
    // MARK: - Properties

    var bookItemViewModel: BookItemViewModel = BookItemViewModel() {
        didSet {
            updateUI()
        }
    }

    // MARK: - Private Functions
    private func updateUI() {
        bookImageView.setImage(urlStr: bookItemViewModel.imageURL)
    }

}
