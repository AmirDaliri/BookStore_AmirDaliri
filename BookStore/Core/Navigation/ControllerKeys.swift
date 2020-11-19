//
//  ControllerKeys.swift
//  BookStore
//
//  Created by amir on 19.11.2020.
//

import UIKit

typealias ControllerKey = String

let kControllerMap: [ ControllerKey: (classType: UIViewController.Type, title: String)] =
    [ControllerKeys.books.rawValue: (BooksViewController.self, ""),
     ControllerKeys.book.rawValue: (BookViewController.self, "")
]

enum ControllerKeys: ControllerKey {
    case books
    case book
}
