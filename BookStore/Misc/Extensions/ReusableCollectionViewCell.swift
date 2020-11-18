//
//  ReusableCollectionViewCell.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol UICollectionViewCellLoading {
}

extension UICollectionViewCellLoading where Self: UICollectionViewCell {
    static func loadFromNib() -> Self {
        let nib = UINib(nibName: String(describing: self), bundle: nil)
        return (nib.instantiate(withOwner: self, options: nil).first as? Self)!
    }
}

extension UICollectionViewCell: Reusable { }

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellClass: T.Type = T.self) {
        let bundle = Bundle(for: cellClass.self)
        if bundle.path(forResource: cellClass.reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            register(cellClass.self, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }
    }
}

