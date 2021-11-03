//
//  Order.swift
//  Samokat
//
//  Created by Daniyar on 8/2/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class CreateOrderData: Codable {
    var orderId: Int?
    
    enum CodingKeys: String, CodingKey {
        case orderId
    }
}

class CreateOrderResponse: Codable {
    var data: CreateOrderData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

class Payment: Codable {
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}

class Order: Codable {
    var orderId: Int?
    var totalAmount: Double?
    var address: String?
    var payment: Payment
    var phoneNumber: String?
    var status: String?
    var startDate: String?
    var endDate: String?
    var products: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case orderId, totalAmount, address, payment, phoneNumber, status, startDate, endDate, products
    }
}

class GetOrdersData: Codable {
    var orders: [Order]?
    
    enum CodingKeys: String, CodingKey {
        case orders
    }
}

class GetOrdersResponse: Codable {
    var data: GetOrdersData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
