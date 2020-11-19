//
//  BaseVM.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Foundation

class BaseVM {
    private(set) var state = Observable(State.unknown)

    func setState(_ state: State) {
        self.state.value = state
    }
    
    func handlePopup(error: BackendError?) {
        if let err = error {
            self.setState(.error(err))
        } else {
            self.setState(.error(nil))
        }
    }
}
