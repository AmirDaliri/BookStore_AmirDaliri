//
//  MainRequest.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Foundation
import Alamofire

class MainRequest: NSObject {
    static let shared = MainRequest()
    
    func getBooks(index: Int, _ completionHandler: @escaping (Error?, Books?) -> Void) {
        DefaultAlamofireManager.sharedManager.request(APIRouter.getBooks(q: "ios", max: 20, index: index)).validate().responseJSON { (response) in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let books = try decoder.decode(Books.self, from: data)
                        completionHandler(nil, books)
                    } catch {
                        completionHandler(BackendError.objectSerialization(reason: error), nil)
                    }
                }
            case .failure(let err):
                switch response.response?.statusCode {
                case 400:
                    completionHandler(BackendError.badAPIRequest(error: err), nil)
                case 401:
                    completionHandler(BackendError.unauthorized(error: err), nil)
                default:
                    guard NetworkReachabilityManager()?.isReachable ?? false else {
                        completionHandler(BackendError.noInternet(error: err), nil)
                        return
                    }
                    completionHandler(BackendError.unknown(error: err), nil)
                }
            }
        }
    }
}
