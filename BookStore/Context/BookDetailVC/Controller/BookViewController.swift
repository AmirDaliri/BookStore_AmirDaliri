//
//  BookViewController.swift
//  BookStore
//
//  Created by amir on 19.11.2020.
//

import UIKit

class BookViewController: BaseVC {

    // MARK: - IBOutlets
    @IBOutlet private weak var bookImageView: UIImageView! {
        didSet {
            bookImageView.setShadow(shadowRadiuss: 8, shadowheight: 0, shadowOpacity: 20, shadowColor: .white)
        }
    }
    @IBOutlet private weak var topHolderView: CurvedView!
    @IBOutlet private weak var buyButton: UIButton! {
        didSet {
            buyButton.backgroundColor = #colorLiteral(red: 1, green: 0.5254901961, blue: 0, alpha: 1)
            buyButton.setTitleColor(.white, for: .normal)
            buyButton.roundCorners(corners: .allCorners, radius: 12)
        }
    }
    @IBOutlet private weak var bookNameLabel: UILabel!
    @IBOutlet private weak var bookAuthorsLabel: UILabel!
    @IBOutlet private weak var bookPublishedDateLabel: UILabel!
    @IBOutlet private weak var bookDescriptionLabel: UILabel! 
    
    // MARK: - Properties
    private var bookViewModel = BookViewModel()
    private var sBookItemViewModel = SBookItemViewModel()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
    }

    override func configureUI() {
        super.configureUI()
        if let book = self.data as? Book {
            bookViewModel = BookViewModel(model: book)
            bookImageView.setImage(urlStr: bookViewModel.imageLink)
            bookNameLabel.text = bookViewModel.name
            bookAuthorsLabel.text = bookViewModel.authors
            bookPublishedDateLabel.text = bookViewModel.publishedDate
            bookDescriptionLabel.attributedText = bookViewModel.descriptionAttr
            buyButton.isHidden = bookViewModel.isPurchasesEnable
        } else if let book = self.data as? SBook {
            sBookItemViewModel = SBookItemViewModel(book: book)
            bookNameLabel.text = sBookItemViewModel.title
            bookAuthorsLabel.text = sBookItemViewModel.authors
            bookPublishedDateLabel.text = sBookItemViewModel.publishedDate
            bookDescriptionLabel.attributedText = sBookItemViewModel.descriptionAttr
            buyButton.isHidden = sBookItemViewModel.isPurchasesEnable
            self.navigationItem.rightBarButtonItems = nil
            if let data = sBookItemViewModel.imageData {
                DispatchQueue.main.async {
                    self.bookImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - IBAction
    @IBAction func buyButtonTapped(_ sender: Any) {
        guard (data as? SBook) != nil else {
            NavigationManager.shared.navigateToSafari(url: bookViewModel.buyLink)
            return
        }
        NavigationManager.shared.navigateToSafari(url: sBookItemViewModel.buyLink)
    }
}
