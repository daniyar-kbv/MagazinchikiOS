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
    var maker: String?
    var composition: String?
    
    enum CodingKeys: String, CodingKey {
        case title, unit, maker, composition
    }
    
    init(title: String?, unit: String?, maker: String?, composition: String?) {
        self.title = title
        self.unit = unit
        self.maker = maker
        self.composition = composition
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as? String
        let unit = aDecoder.decodeObject(forKey: "unit") as? String
        let maker = aDecoder.decodeObject(forKey: "maker") as? String
        let composition = aDecoder.decodeObject(forKey: "composition") as? String
        self.init(title: title, unit: unit, maker: maker, composition: composition)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(unit, forKey: "unit")
        aCoder.encode(maker, forKey: "maker")
        aCoder.encode(composition, forKey: "composition")
    }
}
