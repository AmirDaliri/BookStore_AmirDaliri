//
//  MainViewController.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var colllectionView: UICollectionView!{
        didSet {
            colllectionView.register(cellClass: BookCollectionViewCell.self)
        }
    }
    
    // MARK: - Properties
    private var mainViewModel = MainViewModel()
    private var disposal = Disposal()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        bindUI()
        mainViewModel.getBooks()
        navigationItem.rightBarButtonItem = addFavotitesBarButtonItem()
        title = "Books"
    }

    // MARK: - Private Method
    private func bindUI() {
        mainViewModel.state.observe { [weak self] (state) in
            guard let self = self else { return }
            switch state {
            case .success:
                self.updateUI()
            case .error(let err):
                self.handleAlertView(err: err)
            default:
                break
            }
        }.add(to: &disposal)
    }
    
    private func updateUI() {
        colllectionView.reloadData()
    }
    
    private func handleAlertView(err: BackendError?) {
        if let error = err {
            AlertBuilder().message(error.localizedDescription)
                .addCancelAction(title: "OK")
            .show(in: self)
        }
    }
    
    func addFavotitesBarButtonItem() -> UIBarButtonItem? {
        return UIBarButtonItem(image: #imageLiteral(resourceName: "ic_faved"), style: .plain, target: self, action: #selector(favoritesBarButtonTapped(_:)))
    }
    
    
    @objc func favoritesBarButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
}

//MARK:- UICollectionView DataSource&Delegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainViewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? BookCollectionViewCell)!
        if let bookItemViewModel = mainViewModel.bookAtIndex(indexPath.row) {
            cell.bookItemViewModel = bookItemViewModel
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (mainViewModel.numberOfRows - 1) {  //numberofitem count
            mainViewModel.getBooks()
        }
    }
    
}
