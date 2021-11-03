//
//  Address.swift
//  Samokat
//
//  Created by Daniyar on 7/29/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class Address: NSObject, NSCoding {
    var point: Point?
    var city: String?
    var street: String?
    var house: String?
    var flat: String?
    
    init(point: Point?, city: String?, street: String?, house: String?, flat: String?) {
        self.point = point
        self.city = city
        self.street = street
        self.house = house
        self.flat = flat
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let point = aDecoder.decodeObject(forKey: "point") as? Point
        let city = aDecoder.decodeObject(forKey: "city") as? String
        let street = aDecoder.decodeObject(forKey: "street") as? String
        let house = aDecoder.decodeObject(forKey: "house") as? String
        let flat = aDecoder.decodeObject(forKey: "flat") as? String
        self.init(point: point, city: city, street: street, house: house, flat: flat)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(point, forKey: "point")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(street, forKey: "street")
        aCoder.encode(house, forKey: "house")
        aCoder.encode(flat, forKey: "flat")
    }
    
    func getAddress() -> String {
        return "\(street ?? "") \(house ?? ""), \(flat ?? "")"
    }
    
    func getStreetHouse() -> String{
        return "\(street ?? "") \(house ?? "")"
    }
}
