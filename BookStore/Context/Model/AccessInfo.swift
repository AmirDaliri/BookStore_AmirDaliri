//
//  AccessInfo.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class AccessInfo: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let quoteSharingAllowed = "quoteSharingAllowed"
    static let accessViewStatus = "accessViewStatus"
    static let viewability = "viewability"
    static let publicDomain = "publicDomain"
    static let pdf = "pdf"
    static let textToSpeechPermission = "textToSpeechPermission"
    static let embeddable = "embeddable"
    static let epub = "epub"
    static let country = "country"
    static let webReaderLink = "webReaderLink"
  }

  // MARK: Properties
  var quoteSharingAllowed: Bool? = false
  var accessViewStatus: String?
  var viewability: String?
  var publicDomain: Bool? = false
  var pdf: Pdf?
  var textToSpeechPermission: String?
  var embeddable: Bool? = false
  var epub: Epub?
  var country: String?
  var webReaderLink: String?

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
    quoteSharingAllowed <- map[SerializationKeys.quoteSharingAllowed]
    accessViewStatus <- map[SerializationKeys.accessViewStatus]
    viewability <- map[SerializationKeys.viewability]
    publicDomain <- map[SerializationKeys.publicDomain]
    pdf <- map[SerializationKeys.pdf]
    textToSpeechPermission <- map[SerializationKeys.textToSpeechPermission]
    embeddable <- map[SerializationKeys.embeddable]
    epub <- map[SerializationKeys.epub]
    country <- map[SerializationKeys.country]
    webReaderLink <- map[SerializationKeys.webReaderLink]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.quoteSharingAllowed] = quoteSharingAllowed
    if let value = accessViewStatus { dictionary[SerializationKeys.accessViewStatus] = value }
    if let value = viewability { dictionary[SerializationKeys.viewability] = value }
    dictionary[SerializationKeys.publicDomain] = publicDomain
    if let value = pdf { dictionary[SerializationKeys.pdf] = value.dictionaryRepresentation() }
    if let value = textToSpeechPermission { dictionary[SerializationKeys.textToSpeechPermission] = value }
    dictionary[SerializationKeys.embeddable] = embeddable
    if let value = epub { dictionary[SerializationKeys.epub] = value.dictionaryRepresentation() }
    if let value = country { dictionary[SerializationKeys.country] = value }
    if let value = webReaderLink { dictionary[SerializationKeys.webReaderLink] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.quoteSharingAllowed = aDecoder.decodeBool(forKey: SerializationKeys.quoteSharingAllowed)
    self.accessViewStatus = aDecoder.decodeObject(forKey: SerializationKeys.accessViewStatus) as? String
    self.viewability = aDecoder.decodeObject(forKey: SerializationKeys.viewability) as? String
    self.publicDomain = aDecoder.decodeBool(forKey: SerializationKeys.publicDomain)
    self.pdf = aDecoder.decodeObject(forKey: SerializationKeys.pdf) as? Pdf
    self.textToSpeechPermission = aDecoder.decodeObject(forKey: SerializationKeys.textToSpeechPermission) as? String
    self.embeddable = aDecoder.decodeBool(forKey: SerializationKeys.embeddable)
    self.epub = aDecoder.decodeObject(forKey: SerializationKeys.epub) as? Epub
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
    self.webReaderLink = aDecoder.decodeObject(forKey: SerializationKeys.webReaderLink) as? String
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(quoteSharingAllowed, forKey: SerializationKeys.quoteSharingAllowed)
    aCoder.encode(accessViewStatus, forKey: SerializationKeys.accessViewStatus)
    aCoder.encode(viewability, forKey: SerializationKeys.viewability)
    aCoder.encode(publicDomain, forKey: SerializationKeys.publicDomain)
    aCoder.encode(pdf, forKey: SerializationKeys.pdf)
    aCoder.encode(textToSpeechPermission, forKey: SerializationKeys.textToSpeechPermission)
    aCoder.encode(embeddable, forKey: SerializationKeys.embeddable)
    aCoder.encode(epub, forKey: SerializationKeys.epub)
    aCoder.encode(country, forKey: SerializationKeys.country)
    aCoder.encode(webReaderLink, forKey: SerializationKeys.webReaderLink)
  }

}
