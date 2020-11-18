//
//  SearchInfo.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class SearchInfo: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let textSnippet = "textSnippet"
  }

  // MARK: Properties
  var textSnippet: String?

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
    textSnippet <- map[SerializationKeys.textSnippet]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = textSnippet { dictionary[SerializationKeys.textSnippet] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.textSnippet = aDecoder.decodeObject(forKey: SerializationKeys.textSnippet) as? String
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(textSnippet, forKey: SerializationKeys.textSnippet)
  }

}
