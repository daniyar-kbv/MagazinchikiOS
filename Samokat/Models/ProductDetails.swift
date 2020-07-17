//
//  ProductDetails.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class ProductDetails: NSObject, Codable, NSCoding {
    var title: String?
    var unit: String?
    
    enum CodingKeys: String, CodingKey {
        case title, unit
    }
    
    init(title: String?, unit: String?) {
        self.title = title
        self.unit = unit
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as? String
        let unit = aDecoder.decodeObject(forKey: "unit") as? String
        self.init(title: title, unit: unit)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(unit, forKey: "unit")
    }
}
