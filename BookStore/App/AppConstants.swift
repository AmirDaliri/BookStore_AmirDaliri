//
//  AppConstants.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Foundation

class AppConstants {
    static let baseURL = "https://www.googleapis.com/books/v1/volumes"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
