//
//  TableViewHelper.swift
//  BookStore
//
//  Created by amir on 20.11.2020.
//

import Foundation
import UIKit

class TableViewHelper: NSObject {
    static let shared = TableViewHelper()
    
    func EmptyMessage(message:String, viewController: UIViewController, tableView: UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.white
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messageLabel.sizeToFit()

        tableView.backgroundView = messageLabel;
        tableView.separatorStyle = .none;
    }
}
