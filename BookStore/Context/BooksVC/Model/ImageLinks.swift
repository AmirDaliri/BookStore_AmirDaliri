//
//  ImageLinks.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class ImageLinks: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let thumbnail = "thumbnail"
    static let smallThumbnail = "smallThumbnail"
  }

  // MARK: Properties
  var thumbnail: String?
  var smallThumbnail: String?

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
    thumbnail <- map[SerializationKeys.thumbnail]
    smallThumbnail <- map[SerializationKeys.smallThumbnail]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value }
    if let value = smallThumbnail { dictionary[SerializationKeys.smallThumbnail] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? String
    self.smallThumbnail = aDecoder.decodeObject(forKey: SerializationKeys.smallThumbnail) as? String
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
    aCoder.encode(smallThumbnail, forKey: SerializationKeys.smallThumbnail)
  }

}
