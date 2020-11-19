//
//  MainViewController.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import UIKit

class BooksViewController: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!{
        didSet {
            collectionView.register(cellClass: BookCollectionViewCell.self)
        }
    }
    
    // MARK: - Properties
    private var booksViewModel = BooksViewModel()
    private var disposal = Disposal()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        bindUI()
        booksViewModel.getBooks()
    }
    
    override func configureUI() {
        super.configureUI()
        pageTitle = "Books"
    }
    
    // MARK: - Private Method
    private func bindUI() {
        booksViewModel.state.observe { [weak self] (state) in
            guard let self = self else { return }
            switch state {
            case .success:
                self.updateUI()
            case .error(let err):
                self.handleAlertView(title: nil, message: err?.localizedDescription ?? "")
            default:
                break
            }
        }.add(to: &disposal)
    }
    
    private func updateUI() {
        collectionView.reloadData()
    }
    
}

//MARK:- UICollectionView DataSource&Delegate
extension BooksViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksViewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? BookCollectionViewCell)!
        if let bookItemViewModel = booksViewModel.bookItemViewModelAtIndex(indexPath.row) {
            cell.bookItemViewModel = bookItemViewModel
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Coordinator.shared.requestNavigation(.book, data: booksViewModel.bookAtIndex(indexPath.row), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (booksViewModel.numberOfRows - 1) {
            booksViewModel.getBooks()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Method
extension BooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  40
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 60, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
