//
//  BaseVC.swift
//  BookStore
//
//  Created by amir on 19.11.2020.
//

import UIKit
import CoreData

enum NavigationBarButtonType: Int {
    case favorites = 1
    case favorite = 2
    case unFavorite = 3
}

class BaseVC: UIViewController {
            
    // MARK: Preferred Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: Preferred View Controller Styles
    var isNavigationBarHidden: Bool = false {
        didSet {
            configureNavigationBar()
        }
    }
    
    var pageTitle: String? {
        didSet {
            self.title = self.pageTitle
        }
    }
    
    // MARK: Base Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
        
    func configureUI() {
        view.clipsToBounds = true
        configureNavigationBar()
    }
    
    deinit {
        self.data = nil
    }
    
    // MARK: - Configure NavigationBar
    func configureNavigationBar() {
        if !isNavigationBarHidden {
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationItem.rightBarButtonItems = self.rightBarButtonItems()
            navigationController?.navigationBar.barTintColor = .darkGray
            navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5254901961, blue: 0, alpha: 1)
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
    // MARK: - Setup BarButtonItems
    func rightBarButtonItems() -> [UIBarButtonItem] {
        var array: [UIBarButtonItem] = []
        if self.isKind(of: BooksViewController.self) {
            array.append(self.createBarButtonItem(.favorites))
        }
        if self.isKind(of: BookViewController.self) {
            if shouldCreateFaveBarButton() {
                array.append(self.createBarButtonItem(.favorite))
            } else {
                array.append(self.createBarButtonItem(.unFavorite))
            }
        }
        return array
    }

    func shouldCreateFaveBarButton() -> Bool{
        if let book = self.data as? Book  {
            let controller = CoreDataManager.shared.getSbookNSFetchedResultsController()
            if let items = controller.fetchedObjects {
                for i in items {
                    if book.id == i.id {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    @objc private func barButtonAction(_ button: UIButton) {
        self.navigationBarButtonAction(NavigationBarButtonType(rawValue: button.tag)!)
    }
    
    func navigationBarButtonAction(_ type: NavigationBarButtonType) {
        switch type {
        case .favorites:
            Coordinator.shared.requestNavigation(.faves)
        case .favorite:
            if let book = self.data as? Book  {
                let controller = CoreDataManager.shared.getSbookNSFetchedResultsController()
                if let items = controller.fetchedObjects,
                   let book = items.first(where: {$0.id == book.id}) {
                    context.delete(book)
                    appDelegate.saveContext()
                    resetNavBarItems()
                }
            }
        case .unFavorite:
            if let book = self.data as? Book  {
                CoreDataManager.shared.addToFavorite(book: book)
                resetNavBarItems()
            }
        }
    }
    
    func createBarButtonItem(_ type: NavigationBarButtonType) -> UIBarButtonItem {
        let button: UIButton = UIButton(type: .system)
        button.addTarget(self, action: #selector(self.barButtonAction(_:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        button.contentMode = .center
        button.tag = type.rawValue
        switch type {
        case .favorites:
            button.setTitle("Favorites", for: .normal)
        case .favorite:
            button.setImage(#imageLiteral(resourceName: "ic_faved"), for: .normal)
        case .unFavorite:
            button.setImage(#imageLiteral(resourceName: "ic_fave"), for: .normal)
        }
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.tag = type.rawValue
        return barButtonItem
    }
    
    func resetNavBarItems() {
        self.navigationItem.rightBarButtonItems = nil
        self.navigationItem.rightBarButtonItems = self.rightBarButtonItems()
    }
    
    //MARK: - this function configured for use in bindUI error case.
    public func handleAlertView(title: String?, message: String) {
        if let alertTitle = title {
            AlertBuilder().title(alertTitle).message(message)
                .addCancelAction(title: "OK")
            .show(in: self)
        } else {
            AlertBuilder().message(message)
                .addCancelAction(title: "OK")
            .show(in: self)
        }
    }
}
