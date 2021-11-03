//
//  General.swift
//  Samokat
//
//  Created by Daniyar on 7/30/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class GeneralData: Codable {
    
}

class GeneralResponse: Codable {
    var data: GeneralData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
