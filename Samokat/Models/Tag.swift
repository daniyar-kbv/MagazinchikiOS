//
//  Tag.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class Tag: Codable {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
