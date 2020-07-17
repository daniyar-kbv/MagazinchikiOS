//
//  SubCategory.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class SubCategoryResponse: Codable {
    var data: SubCategoryData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

class SubCategoryData: Codable {
    var subCategory: SubCategory?
    
    enum CodingKeys: String, CodingKey {
        case subCategory
    }
}

class SubCategory: Codable {
    var id: Int?
    var title: String?
    var categoryId: Int?
    var products: [Product]?
    var tags: [Tag]?
    
    enum CodingKeys: String, CodingKey {
        case id, categoryId
        case title
        case products
        case tags
    }
}
