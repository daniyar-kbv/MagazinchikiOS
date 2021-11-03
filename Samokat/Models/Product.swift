//
//  Product.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class ProductResponse: Codable {
    var data: ProductData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

class ProductData: Codable {
    var product: Product?
    
    enum CodingKeys: String, CodingKey {
        case product
    }
}

class Product: NSObject, Codable, NSCoding {
    var id: Int?
    var icon: String?
    var bigIcon: String?
    var bgColor: String?
    var description_: String?
    var properties: ProductProperties?
    var details: ProductDetails?
    var price: ProductPrice?
    var tags: [Tag]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case icon
        case bigIcon
        case bgColor
        case description_ = "description"
        case properties
        case details
        case price
        case tags
    }
    
    init(id: Int?, icon: String?, bigIcon: String?, bgColor: String?, description_: String?, properties: ProductProperties?, details: ProductDetails?, price: ProductPrice?, tags: [Tag]?) {
        self.id = id
        self.icon = icon
        self.bigIcon = bigIcon
        self.bgColor = bgColor
        self.description_ = description_
        self.properties = properties
        self.details = details
        self.price = price
        self.tags = tags
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let icon = aDecoder.decodeObject(forKey: "icon") as? String
        let bigIcon = aDecoder.decodeObject(forKey: "bigIcon") as? String
        let bgColor = aDecoder.decodeObject(forKey: "bgColor") as? String
        let description_ = aDecoder.decodeObject(forKey: "description_") as? String
        let properties = aDecoder.decodeObject(forKey: "properties") as? ProductProperties
        let details = aDecoder.decodeObject(forKey: "details") as? ProductDetails
        let price = aDecoder.decodeObject(forKey: "price") as? ProductPrice
        let tags = aDecoder.decodeObject(forKey: "tags") as? [Tag]
        self.init(id: id, icon: icon, bigIcon: bigIcon, bgColor: bgColor, description_: description_, properties: properties, details: details, price: price, tags: tags)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(icon, forKey: "icon")
        aCoder.encode(bigIcon, forKey: "bigIcon")
        aCoder.encode(bgColor, forKey: "bgColor")
        aCoder.encode(description_, forKey: "description_")
        aCoder.encode(properties, forKey: "properties")
        aCoder.encode(details, forKey: "details")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(tags, forKey: "tags")
    }
}
