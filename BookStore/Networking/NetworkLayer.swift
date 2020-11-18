//
//  NetworkLayer.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Foundation
import Alamofire

class DefaultAlamofireManager: Alamofire.Session {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}

public enum BackendError: Error {
    case noInternet(error: Error) ///Internal errors
    case badAPIRequest(error: Error) ///API errors
    case unauthorized(error: Error) ///Auth errors
    case unknown(error: Error) ///Unknown errors
    case objectSerialization(reason: Error)
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
}
