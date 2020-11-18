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
    static let saleability = "saleability"
    static let listPrice = "listPrice"
    static let buyLink = "buyLink"
    static let retailPrice = "retailPrice"
    static let country = "country"
    static let offers = "offers"
    static let isEbook = "isEbook"
  }

  // MARK: Properties
  var saleability: String?
  var listPrice: ListPrice?
  var buyLink: String?
  var retailPrice: RetailPrice?
  var country: String?
  var offers: [Offers]?
  var isEbook: Bool? = false

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
    saleability <- map[SerializationKeys.saleability]
    listPrice <- map[SerializationKeys.listPrice]
    buyLink <- map[SerializationKeys.buyLink]
    retailPrice <- map[SerializationKeys.retailPrice]
    country <- map[SerializationKeys.country]
    offers <- map[SerializationKeys.offers]
    isEbook <- map[SerializationKeys.isEbook]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = saleability { dictionary[SerializationKeys.saleability] = value }
    if let value = listPrice { dictionary[SerializationKeys.listPrice] = value.dictionaryRepresentation() }
    if let value = buyLink { dictionary[SerializationKeys.buyLink] = value }
    if let value = retailPrice { dictionary[SerializationKeys.retailPrice] = value.dictionaryRepresentation() }
    if let value = country { dictionary[SerializationKeys.country] = value }
    if let value = offers { dictionary[SerializationKeys.offers] = value.map { $0.dictionaryRepresentation() } }
    dictionary[SerializationKeys.isEbook] = isEbook
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.saleability = aDecoder.decodeObject(forKey: SerializationKeys.saleability) as? String
    self.listPrice = aDecoder.decodeObject(forKey: SerializationKeys.listPrice) as? ListPrice
    self.buyLink = aDecoder.decodeObject(forKey: SerializationKeys.buyLink) as? String
    self.retailPrice = aDecoder.decodeObject(forKey: SerializationKeys.retailPrice) as? RetailPrice
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
    self.offers = aDecoder.decodeObject(forKey: SerializationKeys.offers) as? [Offers]
    self.isEbook = aDecoder.decodeBool(forKey: SerializationKeys.isEbook)
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(saleability, forKey: SerializationKeys.saleability)
    aCoder.encode(listPrice, forKey: SerializationKeys.listPrice)
    aCoder.encode(buyLink, forKey: SerializationKeys.buyLink)
    aCoder.encode(retailPrice, forKey: SerializationKeys.retailPrice)
    aCoder.encode(country, forKey: SerializationKeys.country)
    aCoder.encode(offers, forKey: SerializationKeys.offers)
    aCoder.encode(isEbook, forKey: SerializationKeys.isEbook)
  }

}
