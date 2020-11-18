//
//  Books.swift
//
//  Created by amir on 18.11.2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class Books: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let totalItems = "totalItems"
        static let kind = "kind"
        static let items = "items"
    }
    
    // MARK: Properties
    var totalItems: Int?
    var kind: String?
    var items: [Items]?
    
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
        totalItems <- map[SerializationKeys.totalItems]
        kind <- map[SerializationKeys.kind]
        items <- map[SerializationKeys.items]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = totalItems { dictionary[SerializationKeys.totalItems] = value }
        if let value = kind { dictionary[SerializationKeys.kind] = value }
        if let value = items { dictionary[SerializationKeys.items] = value.map { $0.dictionaryRepresentation() } }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required init(coder aDecoder: NSCoder) {
        self.totalItems = aDecoder.decodeObject(forKey: SerializationKeys.totalItems) as? Int
        self.kind = aDecoder.decodeObject(forKey: SerializationKeys.kind) as? String
        self.items = aDecoder.decodeObject(forKey: SerializationKeys.items) as? [Items]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(totalItems, forKey: SerializationKeys.totalItems)
        aCoder.encode(kind, forKey: SerializationKeys.kind)
        aCoder.encode(items, forKey: SerializationKeys.items)
    }
    
}
