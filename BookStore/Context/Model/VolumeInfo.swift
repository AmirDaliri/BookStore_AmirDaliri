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
    static let averageRating = "averageRating"
    static let allowAnonLogging = "allowAnonLogging"
    static let language = "language"
    static let printType = "printType"
    static let previewLink = "previewLink"
    static let imageLinks = "imageLinks"
    static let ratingsCount = "ratingsCount"
    static let readingModes = "readingModes"
    static let canonicalVolumeLink = "canonicalVolumeLink"
    static let maturityRating = "maturityRating"
    static let categories = "categories"
    static let publishedDate = "publishedDate"
    static let title = "title"
    static let pageCount = "pageCount"
    static let infoLink = "infoLink"
    static let authors = "authors"
    static let industryIdentifiers = "industryIdentifiers"
    static let subtitle = "subtitle"
    static let descriptionValue = "description"
    static let panelizationSummary = "panelizationSummary"
    static let contentVersion = "contentVersion"
    static let publisher = "publisher"
  }

  // MARK: Properties
  var averageRating: Int?
  var allowAnonLogging: Bool? = false
  var language: String?
  var printType: String?
  var previewLink: String?
  var imageLinks: ImageLinks?
  var ratingsCount: Int?
  var readingModes: ReadingModes?
  var canonicalVolumeLink: String?
  var maturityRating: String?
  var categories: [String]?
  var publishedDate: String?
  var title: String?
  var pageCount: Int?
  var infoLink: String?
  var authors: [String]?
  var industryIdentifiers: [IndustryIdentifiers]?
  var subtitle: String?
  var descriptionValue: String?
  var panelizationSummary: PanelizationSummary?
  var contentVersion: String?
  var publisher: String?

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
    averageRating <- map[SerializationKeys.averageRating]
    allowAnonLogging <- map[SerializationKeys.allowAnonLogging]
    language <- map[SerializationKeys.language]
    printType <- map[SerializationKeys.printType]
    previewLink <- map[SerializationKeys.previewLink]
    imageLinks <- map[SerializationKeys.imageLinks]
    ratingsCount <- map[SerializationKeys.ratingsCount]
    readingModes <- map[SerializationKeys.readingModes]
    canonicalVolumeLink <- map[SerializationKeys.canonicalVolumeLink]
    maturityRating <- map[SerializationKeys.maturityRating]
    categories <- map[SerializationKeys.categories]
    publishedDate <- map[SerializationKeys.publishedDate]
    title <- map[SerializationKeys.title]
    pageCount <- map[SerializationKeys.pageCount]
    infoLink <- map[SerializationKeys.infoLink]
    authors <- map[SerializationKeys.authors]
    industryIdentifiers <- map[SerializationKeys.industryIdentifiers]
    subtitle <- map[SerializationKeys.subtitle]
    descriptionValue <- map[SerializationKeys.descriptionValue]
    panelizationSummary <- map[SerializationKeys.panelizationSummary]
    contentVersion <- map[SerializationKeys.contentVersion]
    publisher <- map[SerializationKeys.publisher]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = averageRating { dictionary[SerializationKeys.averageRating] = value }
    dictionary[SerializationKeys.allowAnonLogging] = allowAnonLogging
    if let value = language { dictionary[SerializationKeys.language] = value }
    if let value = printType { dictionary[SerializationKeys.printType] = value }
    if let value = previewLink { dictionary[SerializationKeys.previewLink] = value }
    if let value = imageLinks { dictionary[SerializationKeys.imageLinks] = value.dictionaryRepresentation() }
    if let value = ratingsCount { dictionary[SerializationKeys.ratingsCount] = value }
    if let value = readingModes { dictionary[SerializationKeys.readingModes] = value.dictionaryRepresentation() }
    if let value = canonicalVolumeLink { dictionary[SerializationKeys.canonicalVolumeLink] = value }
    if let value = maturityRating { dictionary[SerializationKeys.maturityRating] = value }
    if let value = categories { dictionary[SerializationKeys.categories] = value }
    if let value = publishedDate { dictionary[SerializationKeys.publishedDate] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = pageCount { dictionary[SerializationKeys.pageCount] = value }
    if let value = infoLink { dictionary[SerializationKeys.infoLink] = value }
    if let value = authors { dictionary[SerializationKeys.authors] = value }
    if let value = industryIdentifiers { dictionary[SerializationKeys.industryIdentifiers] = value.map { $0.dictionaryRepresentation() } }
    if let value = subtitle { dictionary[SerializationKeys.subtitle] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = panelizationSummary { dictionary[SerializationKeys.panelizationSummary] = value.dictionaryRepresentation() }
    if let value = contentVersion { dictionary[SerializationKeys.contentVersion] = value }
    if let value = publisher { dictionary[SerializationKeys.publisher] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required init(coder aDecoder: NSCoder) {
    self.averageRating = aDecoder.decodeObject(forKey: SerializationKeys.averageRating) as? Int
    self.allowAnonLogging = aDecoder.decodeBool(forKey: SerializationKeys.allowAnonLogging)
    self.language = aDecoder.decodeObject(forKey: SerializationKeys.language) as? String
    self.printType = aDecoder.decodeObject(forKey: SerializationKeys.printType) as? String
    self.previewLink = aDecoder.decodeObject(forKey: SerializationKeys.previewLink) as? String
    self.imageLinks = aDecoder.decodeObject(forKey: SerializationKeys.imageLinks) as? ImageLinks
    self.ratingsCount = aDecoder.decodeObject(forKey: SerializationKeys.ratingsCount) as? Int
    self.readingModes = aDecoder.decodeObject(forKey: SerializationKeys.readingModes) as? ReadingModes
    self.canonicalVolumeLink = aDecoder.decodeObject(forKey: SerializationKeys.canonicalVolumeLink) as? String
    self.maturityRating = aDecoder.decodeObject(forKey: SerializationKeys.maturityRating) as? String
    self.categories = aDecoder.decodeObject(forKey: SerializationKeys.categories) as? [String]
    self.publishedDate = aDecoder.decodeObject(forKey: SerializationKeys.publishedDate) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.pageCount = aDecoder.decodeObject(forKey: SerializationKeys.pageCount) as? Int
    self.infoLink = aDecoder.decodeObject(forKey: SerializationKeys.infoLink) as? String
    self.authors = aDecoder.decodeObject(forKey: SerializationKeys.authors) as? [String]
    self.industryIdentifiers = aDecoder.decodeObject(forKey: SerializationKeys.industryIdentifiers) as? [IndustryIdentifiers]
    self.subtitle = aDecoder.decodeObject(forKey: SerializationKeys.subtitle) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.panelizationSummary = aDecoder.decodeObject(forKey: SerializationKeys.panelizationSummary) as? PanelizationSummary
    self.contentVersion = aDecoder.decodeObject(forKey: SerializationKeys.contentVersion) as? String
    self.publisher = aDecoder.decodeObject(forKey: SerializationKeys.publisher) as? String
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(averageRating, forKey: SerializationKeys.averageRating)
    aCoder.encode(allowAnonLogging, forKey: SerializationKeys.allowAnonLogging)
    aCoder.encode(language, forKey: SerializationKeys.language)
    aCoder.encode(printType, forKey: SerializationKeys.printType)
    aCoder.encode(previewLink, forKey: SerializationKeys.previewLink)
    aCoder.encode(imageLinks, forKey: SerializationKeys.imageLinks)
    aCoder.encode(ratingsCount, forKey: SerializationKeys.ratingsCount)
    aCoder.encode(readingModes, forKey: SerializationKeys.readingModes)
    aCoder.encode(canonicalVolumeLink, forKey: SerializationKeys.canonicalVolumeLink)
    aCoder.encode(maturityRating, forKey: SerializationKeys.maturityRating)
    aCoder.encode(categories, forKey: SerializationKeys.categories)
    aCoder.encode(publishedDate, forKey: SerializationKeys.publishedDate)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(pageCount, forKey: SerializationKeys.pageCount)
    aCoder.encode(infoLink, forKey: SerializationKeys.infoLink)
    aCoder.encode(authors, forKey: SerializationKeys.authors)
    aCoder.encode(industryIdentifiers, forKey: SerializationKeys.industryIdentifiers)
    aCoder.encode(subtitle, forKey: SerializationKeys.subtitle)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(panelizationSummary, forKey: SerializationKeys.panelizationSummary)
    aCoder.encode(contentVersion, forKey: SerializationKeys.contentVersion)
    aCoder.encode(publisher, forKey: SerializationKeys.publisher)
  }

}
