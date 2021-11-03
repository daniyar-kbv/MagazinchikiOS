//
//  Phone.swift
//  Samokat
//
//  Created by Daniyar on 7/15/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class PhoneResponse: Codable {
    var data: PhoneData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}


class PhoneData: Codable {
}


class CheckSmsResponse: Codable {
    var data: CheckSmsData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

class CheckSmsData: Codable {
}
