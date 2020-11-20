//
//  SaleInfo.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class SaleInfo: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let listPrice = "listPrice"
    static let buyLink = "buyLink"
  }

  // MARK: Properties
  var listPrice: ListPrice?
  var buyLink: String?

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
    listPrice <- map[SerializationKeys.listPrice]
    buyLink <- map[SerializationKeys.buyLink]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = listPrice { dictionary[SerializationKeys.listPrice] = value.dictionaryRepresentation() }
    if let value = buyLink { dictionary[SerializationKeys.buyLink] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.listPrice = aDecoder.decodeObject(forKey: SerializationKeys.listPrice) as? ListPrice
    self.buyLink = aDecoder.decodeObject(forKey: SerializationKeys.buyLink) as? String
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(listPrice, forKey: SerializationKeys.listPrice)
    aCoder.encode(buyLink, forKey: SerializationKeys.buyLink)
  }

}
