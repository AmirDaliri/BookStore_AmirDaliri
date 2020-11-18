//
//  MainViewController.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    private var mainViewModel = MainViewModel()
    private var disposal = Disposal()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        bindUI()
        mainViewModel.getBooks(index: 0)
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
        // TODO:  load UI
    }
    
    private func handleAlertView(err: BackendError?) {
        if let error = err {
            AlertBuilder().message(error.localizedDescription)
                .addCancelAction(title: "OK")
            .show(in: self)
        }
    }
}
