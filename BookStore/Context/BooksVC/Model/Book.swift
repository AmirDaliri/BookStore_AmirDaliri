//
//  Items.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class Book: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let selfLink = "selfLink"
        static let etag = "etag"
        static let saleInfo = "saleInfo"
        static let accessInfo = "accessInfo"
        static let id = "id"
        static let searchInfo = "searchInfo"
        static let kind = "kind"
        static let volumeInfo = "volumeInfo"
    }
    
    // MARK: Properties
    var selfLink: String?
    var etag: String?
    var saleInfo: SaleInfo?
    var accessInfo: AccessInfo?
    var id: String?
    var searchInfo: SearchInfo?
    var kind: String?
    var volumeInfo: VolumeInfo?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    required init?(map: Map){}
    
    init() {}
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    func mapping(map: Map) {
        selfLink <- map[SerializationKeys.selfLink]
        etag <- map[SerializationKeys.etag]
        saleInfo <- map[SerializationKeys.saleInfo]
        accessInfo <- map[SerializationKeys.accessInfo]
        id <- map[SerializationKeys.id]
        searchInfo <- map[SerializationKeys.searchInfo]
        kind <- map[SerializationKeys.kind]
        volumeInfo <- map[SerializationKeys.volumeInfo]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = selfLink { dictionary[SerializationKeys.selfLink] = value }
        if let value = etag { dictionary[SerializationKeys.etag] = value }
        if let value = saleInfo { dictionary[SerializationKeys.saleInfo] = value.dictionaryRepresentation() }
        if let value = accessInfo { dictionary[SerializationKeys.accessInfo] = value.dictionaryRepresentation() }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = searchInfo { dictionary[SerializationKeys.searchInfo] = value.dictionaryRepresentation() }
        if let value = kind { dictionary[SerializationKeys.kind] = value }
        if let value = volumeInfo { dictionary[SerializationKeys.volumeInfo] = value.dictionaryRepresentation() }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required init(coder aDecoder: NSCoder) {
        self.selfLink = aDecoder.decodeObject(forKey: SerializationKeys.selfLink) as? String
        self.etag = aDecoder.decodeObject(forKey: SerializationKeys.etag) as? String
        self.saleInfo = aDecoder.decodeObject(forKey: SerializationKeys.saleInfo) as? SaleInfo
        self.accessInfo = aDecoder.decodeObject(forKey: SerializationKeys.accessInfo) as? AccessInfo
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
        self.searchInfo = aDecoder.decodeObject(forKey: SerializationKeys.searchInfo) as? SearchInfo
        self.kind = aDecoder.decodeObject(forKey: SerializationKeys.kind) as? String
        self.volumeInfo = aDecoder.decodeObject(forKey: SerializationKeys.volumeInfo) as? VolumeInfo
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(selfLink, forKey: SerializationKeys.selfLink)
        aCoder.encode(etag, forKey: SerializationKeys.etag)
        aCoder.encode(saleInfo, forKey: SerializationKeys.saleInfo)
        aCoder.encode(accessInfo, forKey: SerializationKeys.accessInfo)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(searchInfo, forKey: SerializationKeys.searchInfo)
        aCoder.encode(kind, forKey: SerializationKeys.kind)
        aCoder.encode(volumeInfo, forKey: SerializationKeys.volumeInfo)
    }
    
}
