//
//  PanelizationSummary.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class PanelizationSummary: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let containsImageBubbles = "containsImageBubbles"
    static let containsEpubBubbles = "containsEpubBubbles"
  }

  // MARK: Properties
  var containsImageBubbles: Bool? = false
  var containsEpubBubbles: Bool? = false

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
    containsImageBubbles <- map[SerializationKeys.containsImageBubbles]
    containsEpubBubbles <- map[SerializationKeys.containsEpubBubbles]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.containsImageBubbles] = containsImageBubbles
    dictionary[SerializationKeys.containsEpubBubbles] = containsEpubBubbles
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.containsImageBubbles = aDecoder.decodeBool(forKey: SerializationKeys.containsImageBubbles)
    self.containsEpubBubbles = aDecoder.decodeBool(forKey: SerializationKeys.containsEpubBubbles)
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(containsImageBubbles, forKey: SerializationKeys.containsImageBubbles)
    aCoder.encode(containsEpubBubbles, forKey: SerializationKeys.containsEpubBubbles)
  }

}
