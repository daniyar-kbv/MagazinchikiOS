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

class SubCategory: NSObject, Codable, NSCoding {
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
    
    init(id: Int?, title: String?, categoryId: Int?, products: [Product]?, tags: [Tag]?) {
        self.id = id
        self.title = title
        self.categoryId = categoryId
        self.products = products
        self.tags = tags
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let title = aDecoder.decodeObject(forKey: "title") as? String
        let categoryId = aDecoder.decodeObject(forKey: "categoryId") as? Int
        let products = aDecoder.decodeObject(forKey: "products") as? [Product]
        let tags = aDecoder.decodeObject(forKey: "tags") as? [Tag]
        self.init(id: id, title: title, categoryId: categoryId, products: products, tags: tags)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(categoryId, forKey: "categoryId")
        aCoder.encode(products, forKey: "products")
        aCoder.encode(tags, forKey: "tags")
    }
    
    func filterByTag(tagId: Int?) -> [Product] {
        guard let products = self.products else { return [] }
        guard let tagId = tagId else {
            return products
        }
        let filtered = products.filter {
            guard let tags = $0.tags else { return false }
            return tags.contains(where: {
                $0.id == tagId
            }) || tags.count == 0
        }
        return filtered
    }
    
    func getTag(tagId: Int) -> Tag? {
        return tags?.first(where: {
            $0.id == tagId
        })
    }
}
