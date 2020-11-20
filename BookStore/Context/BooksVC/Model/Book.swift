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
        static let saleInfo = "saleInfo"
        static let id = "id"
        static let volumeInfo = "volumeInfo"
    }
    
    // MARK: Properties
    var saleInfo: SaleInfo?
    var id: String?
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
        saleInfo <- map[SerializationKeys.saleInfo]
        id <- map[SerializationKeys.id]
        volumeInfo <- map[SerializationKeys.volumeInfo]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = saleInfo { dictionary[SerializationKeys.saleInfo] = value.dictionaryRepresentation() }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = volumeInfo { dictionary[SerializationKeys.volumeInfo] = value.dictionaryRepresentation() }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required init(coder aDecoder: NSCoder) {
        self.saleInfo = aDecoder.decodeObject(forKey: SerializationKeys.saleInfo) as? SaleInfo
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
        self.volumeInfo = aDecoder.decodeObject(forKey: SerializationKeys.volumeInfo) as? VolumeInfo
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(saleInfo, forKey: SerializationKeys.saleInfo)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(volumeInfo, forKey: SerializationKeys.volumeInfo)
    }
    
}
