//
//  ControllerFactory.swift
//  BookStore
//
//  Created by amir on 19.11.2020.
//

import UIKit

class ControllerFactory {
    
    static func navigationController(_ root: UIViewController, popGestureEnabled: Bool = true) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.navigationBar.isOpaque = false
        navigationController.navigationBar.isTranslucent = false
        navigationController.interactivePopGestureRecognizer?.isEnabled = popGestureEnabled
        return navigationController
    }
    
    static func viewController(_ controllerKey: ControllerKey, data: Any? = nil) -> UIViewController? {
        if let nClass = kControllerMap[controllerKey]?.classType {
            let controller = nClass.init()
            controller.controllerKey = controllerKey
            if let safeData = data {
                controller.data = safeData
            }
            return controller
        }
        
        return nil
    }
}
