//
//  ListPrice.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class ListPrice: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let amountInMicros = "amountInMicros"
    static let currencyCode = "currencyCode"
  }

  // MARK: Properties
  var amountInMicros: Int?
  var currencyCode: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  func mapping(map: Map) {
    amountInMicros <- map[SerializationKeys.amountInMicros]
    currencyCode <- map[SerializationKeys.currencyCode]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = amountInMicros { dictionary[SerializationKeys.amountInMicros] = value }
    if let value = currencyCode { dictionary[SerializationKeys.currencyCode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.amountInMicros = aDecoder.decodeObject(forKey: SerializationKeys.amountInMicros) as? Int
    self.currencyCode = aDecoder.decodeObject(forKey: SerializationKeys.currencyCode) as? String
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(amountInMicros, forKey: SerializationKeys.amountInMicros)
    aCoder.encode(currencyCode, forKey: SerializationKeys.currencyCode)
  }

}
