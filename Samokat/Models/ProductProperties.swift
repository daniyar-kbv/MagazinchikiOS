//
//  ProductProperties.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class ProductProperties: NSObject, Codable, NSCoding {
    var kcal: String?
    var protein: String?
    var fat: String?
    var carbohydrates: String?
    
    enum CodingKeys: String, CodingKey {
        case kcal, protein, fat, carbohydrates
    }
    
    init(kcal: String?, protein: String?, fat: String?, carbohydrates: String?) {
        self.kcal = kcal
        self.protein = protein
        self.fat = fat
        self.carbohydrates = carbohydrates
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let kcal = aDecoder.decodeObject(forKey: "kcal") as? String
        let protein = aDecoder.decodeObject(forKey: "protein") as? String
        let fat = aDecoder.decodeObject(forKey: "fat") as? String
        let carbohydrates = aDecoder.decodeObject(forKey: "carbohydrates") as? String
        self.init(kcal: kcal, protein: protein, fat: fat, carbohydrates: carbohydrates)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(kcal, forKey: "kcal")
        aCoder.encode(protein, forKey: "protein")
        aCoder.encode(fat, forKey: "fat")
        aCoder.encode(carbohydrates, forKey: "carbohydrates")
    }
}
