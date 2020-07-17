//
//  Category.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class CategoriesResponse: Codable {
    var data: CategoriesData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

class CategoriesData: Codable {
    var categories: [Category]?
    
    enum CodingKeys: String, CodingKey {
        case categories
    }
}

class CategoryResponse: Codable {
    var data: CategoryData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

class CategoryData: Codable {
    var category: Category?
    
    enum CodingKeys: String, CodingKey {
        case category
    }
}

class Category: Codable {
    var id: Int?
    var title: String?
    var icon: String?
    var bgColor: String?
    var subCategories: [SubCategory]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title, icon, bgColor
        case subCategories
    }
    
    func getSubcategory(id: Int) -> SubCategory? {
        guard let subCategories = subCategories else { return nil }
        for sub in subCategories{
            if sub.id == id {
                return sub
            }
        }
        return nil
    }
}
