//
//  FavoriteTableViewCell.swift
//  BookStore
//
//  Created by amir on 20.11.2020.
//

import UIKit

class FavoriteTableViewCell: BaseTableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var bookImageView: UIImageView!
    @IBOutlet private weak var bookTitleLabel: UILabel!
    @IBOutlet private weak var seperatorView: UIView!
    
    // MARK: - Properties
    var sBookItemViewModel: SBookItemViewModel = SBookItemViewModel() {
        didSet {
            updateUI()
        }
    }
    
    var isSeparatorHidden: Bool = false {
        didSet {
            seperatorView.isHidden = isSeparatorHidden
        }
    }
    
    // MARK: - Private Functions
    private func updateUI() {
        bookTitleLabel.text = sBookItemViewModel.title
        DispatchQueue.main.async {
            if let img = self.sBookItemViewModel.imageData {
                self.bookImageView.image = UIImage(data: img)
            }
        }
    }
    
}
