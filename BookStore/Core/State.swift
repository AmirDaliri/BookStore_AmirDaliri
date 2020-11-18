//
//  State.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Foundation

enum State {
    case unknown, loading, success, error(BackendError?)

    static func == (left: State, right: State) -> Bool {
        switch (left, right) {
        case (.unknown, .unknown):
            return true
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}
