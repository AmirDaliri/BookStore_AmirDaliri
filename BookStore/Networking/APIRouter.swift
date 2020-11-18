//
//  APIRouter.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    
    case getBooks(q: String, max: Int, index: Int)
 
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getBooks:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getBooks:
            return "/volumes"
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {

        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
            case .getBooks(let q, let max, let index):
                let params: [String: AnyObject] = ["q": q as AnyObject, "maxResults": max as AnyObject, "startIndex": index as AnyObject]
                return (path, params)
            }
        }()
        
        // MARK: - Set HTTP Header Field
        let base = URL(string: AppConstants.baseURL)!
        let baseAppend = base.appendingPathComponent(result.path).absoluteString.removingPercentEncoding
        let url = URL(string: baseAppend!)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue
        let encoding = try URLEncoding.default.encode(urlRequest, with: result.parameters)
        return encoding
    }
}
