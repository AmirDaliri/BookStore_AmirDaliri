//
//  Epub.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class Epub: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let isAvailable = "isAvailable"
    static let acsTokenLink = "acsTokenLink"
  }

  // MARK: Properties
  var isAvailable: Bool? = false
  var acsTokenLink: String?

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
    isAvailable <- map[SerializationKeys.isAvailable]
    acsTokenLink <- map[SerializationKeys.acsTokenLink]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.isAvailable] = isAvailable
    if let value = acsTokenLink { dictionary[SerializationKeys.acsTokenLink] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.isAvailable = aDecoder.decodeBool(forKey: SerializationKeys.isAvailable)
    self.acsTokenLink = aDecoder.decodeObject(forKey: SerializationKeys.acsTokenLink) as? String
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(isAvailable, forKey: SerializationKeys.isAvailable)
    aCoder.encode(acsTokenLink, forKey: SerializationKeys.acsTokenLink)
  }

}
