//
//  Error.swift
//  Samokat
//
//  Created by Daniyar on 7/15/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class ErrorResponse: Codable  {
    var error: ErrorData?
    
    enum CodingKeys: String, CodingKey {
        case error
    }
}

class ErrorData: Codable {
    var title: String?
    var type: String?
    var description: String?
    var code: String?
    
    enum CodingKeys: String, CodingKey {
        case title, type, description, code
    }
}
