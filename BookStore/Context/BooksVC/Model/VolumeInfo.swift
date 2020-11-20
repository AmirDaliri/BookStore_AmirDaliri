//
//  VolumeInfo.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class VolumeInfo: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let imageLinks = "imageLinks"
    static let publishedDate = "publishedDate"
    static let title = "title"
    static let authors = "authors"
    static let subtitle = "subtitle"
    static let descriptionValue = "description"
  }

  // MARK: Properties
  var imageLinks: ImageLinks?
  var publishedDate: String?
  var title: String?
  var authors: [String]?
  var subtitle: String?
  var descriptionValue: String?

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
    imageLinks <- map[SerializationKeys.imageLinks]
    publishedDate <- map[SerializationKeys.publishedDate]
    title <- map[SerializationKeys.title]
    authors <- map[SerializationKeys.authors]
    subtitle <- map[SerializationKeys.subtitle]
    descriptionValue <- map[SerializationKeys.descriptionValue]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = imageLinks { dictionary[SerializationKeys.imageLinks] = value.dictionaryRepresentation() }
    if let value = publishedDate { dictionary[SerializationKeys.publishedDate] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = authors { dictionary[SerializationKeys.authors] = value }
    if let value = subtitle { dictionary[SerializationKeys.subtitle] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.imageLinks = aDecoder.decodeObject(forKey: SerializationKeys.imageLinks) as? ImageLinks
    self.publishedDate = aDecoder.decodeObject(forKey: SerializationKeys.publishedDate) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.authors = aDecoder.decodeObject(forKey: SerializationKeys.authors) as? [String]
    self.subtitle = aDecoder.decodeObject(forKey: SerializationKeys.subtitle) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(imageLinks, forKey: SerializationKeys.imageLinks)
    aCoder.encode(publishedDate, forKey: SerializationKeys.publishedDate)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(authors, forKey: SerializationKeys.authors)
    aCoder.encode(subtitle, forKey: SerializationKeys.subtitle)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
  }

}
