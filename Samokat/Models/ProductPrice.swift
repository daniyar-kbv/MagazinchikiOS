//
//  ProductPrice.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class ProductPrice: NSObject, Codable, NSCoding {
    var currentPrice: String?
    var oldPrice: String?
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPrice, oldPrice, count
    }
    
    init(currentPrice: String?, oldPrice: String?, count: Int?) {
        self.currentPrice = currentPrice
        self.oldPrice = oldPrice
        self.count = count
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let currentPrice = aDecoder.decodeObject(forKey: "currentPrice") as? String
        let oldPrice = aDecoder.decodeObject(forKey: "oldPrice") as? String
        let count = aDecoder.decodeObject(forKey: "count") as? Int
        self.init(currentPrice: currentPrice, oldPrice: oldPrice, count: count)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(currentPrice, forKey: "currentPrice")
        aCoder.encode(oldPrice, forKey: "oldPrice")
        aCoder.encode(count, forKey: "count")
    }
}
