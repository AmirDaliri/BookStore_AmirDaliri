//
//  ReadingModes.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class ReadingModes: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let text = "text"
    static let image = "image"
  }

  // MARK: Properties
  var text: Bool? = false
  var image: Bool? = false

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
    text <- map[SerializationKeys.text]
    image <- map[SerializationKeys.image]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.text] = text
    dictionary[SerializationKeys.image] = image
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.text = aDecoder.decodeBool(forKey: SerializationKeys.text)
    self.image = aDecoder.decodeBool(forKey: SerializationKeys.image)
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: SerializationKeys.text)
    aCoder.encode(image, forKey: SerializationKeys.image)
  }

}
