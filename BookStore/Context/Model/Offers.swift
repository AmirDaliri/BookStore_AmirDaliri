//
//  Offers.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class Offers: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let retailPrice = "retailPrice"
    static let finskyOfferType = "finskyOfferType"
    static let listPrice = "listPrice"
  }

  // MARK: Properties
  var retailPrice: RetailPrice?
  var finskyOfferType: Int?
  var listPrice: ListPrice?

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
    retailPrice <- map[SerializationKeys.retailPrice]
    finskyOfferType <- map[SerializationKeys.finskyOfferType]
    listPrice <- map[SerializationKeys.listPrice]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = retailPrice { dictionary[SerializationKeys.retailPrice] = value.dictionaryRepresentation() }
    if let value = finskyOfferType { dictionary[SerializationKeys.finskyOfferType] = value }
    if let value = listPrice { dictionary[SerializationKeys.listPrice] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.retailPrice = aDecoder.decodeObject(forKey: SerializationKeys.retailPrice) as? RetailPrice
    self.finskyOfferType = aDecoder.decodeObject(forKey: SerializationKeys.finskyOfferType) as? Int
    self.listPrice = aDecoder.decodeObject(forKey: SerializationKeys.listPrice) as? ListPrice
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(retailPrice, forKey: SerializationKeys.retailPrice)
    aCoder.encode(finskyOfferType, forKey: SerializationKeys.finskyOfferType)
    aCoder.encode(listPrice, forKey: SerializationKeys.listPrice)
  }

}
