//
//  BaseVC.swift
//  BookStore
//
//  Created by amir on 19.11.2020.
//

import UIKit

enum NavigationBarButtonType: Int {
    case favorites = 1
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
        return array
    }
    
    @objc private func barButtonAction(_ button: UIButton) {
        self.navigationBarButtonAction(NavigationBarButtonType(rawValue: button.tag)!)
    }
    
    func navigationBarButtonAction(_ type: NavigationBarButtonType) {
        /// switch case for handle more than one bar button
        switch type {
        case .favorites:
            Coordinator.shared.requestNavigation(.book)
        }
    }
    
    func createBarButtonItem(_ type: NavigationBarButtonType) -> UIBarButtonItem {
        let button: UIButton = UIButton(type: .system)
        button.addTarget(self, action: #selector(self.barButtonAction(_:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        button.contentMode = .center
        button.tag = type.rawValue
        if type == .favorites {
            button.setTitle("Favorites", for: .normal)
        }
        
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.tag = type.rawValue
        return barButtonItem
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
