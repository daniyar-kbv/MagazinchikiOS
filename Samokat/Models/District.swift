//
//  District.swift
//  Samokat
//
//  Created by Daniyar on 7/21/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import YandexMapKit

class Point: NSObject, Codable, NSCoding {
    var latitude: Double?
    var longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
    
    init(latitude: Double?, longitude: Double?) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let latitude = aDecoder.decodeObject(forKey: "latitude") as? Double
        let longitude = aDecoder.decodeObject(forKey: "longitude") as? Double
        self.init(latitude: latitude, longitude: longitude)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
    }
}

class District: Codable {
    var id: Int?
    var name: String?
    var points: [Point]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case points
    }
}

class DistrictsData: Codable {
    var districts: [District]?
    
    enum CodingKeys: String, CodingKey {
        case districts
    }
    
    func getAllPoints() -> [YMKPoint]{
        var allPoints: [YMKPoint] = []
        for district in districts ?? [] {
            for point in district.points ?? [] {
                if let lat = point.latitude, let lon = point.longitude {
                    allPoints.append(YMKPoint(latitude: lat, longitude: lon))
                }
            }
        }
        return allPoints
    }
}

class DistrictsResponse: Codable {
    var data: DistrictsData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

class FindDistrctData: Codable {
    var districtId: Int?
    var transactionId: String?
    
    enum CodingKeys: String, CodingKey {
        case districtId
        case transactionId
    }
}

class FindDistrictResponse: Codable {
    var data: FindDistrctData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
