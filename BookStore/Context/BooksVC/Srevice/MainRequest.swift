//
//  MainRequest.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import Alamofire
import ObjectMapper

class MainRequest: NSObject {
    static let shared = MainRequest()
    
    func getBooks(index: Int, _ completionHandler: @escaping (BackendError?, Books?) -> Void) {
        DefaultAlamofireManager.sharedManager.request(APIRouter.getBooks(q: "ios", max: 20, index: index)).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let books = Mapper<Books>().map(JSONObject: value) {
                    if books.items != nil {
                        completionHandler(nil, books)
                    } else {
                        completionHandler(BackendError.finishedList(reason: "There is no extra data"), nil)
                    }
                } else {
                    completionHandler(BackendError.objectSerialization(reason: response.error), nil)
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
