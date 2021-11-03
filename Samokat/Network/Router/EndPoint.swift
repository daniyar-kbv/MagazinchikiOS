//
//  EndPoint.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import Alamofire

enum APIPoint {
    case connect
    case categories(districtId: Int, hash: String?)
    case category(id: Int)
    case subCategory(id: Int)
    case product(id: Int)
    case districts
    case findDistrict(latitude: Double, longitude: Double, address: String)
    case checkPhoneNumber(phone: String, transactionId: String)
    case checkSmsCode(sms: String, transactionId: String)
    case resendSms(transactionId: String)
    case createOrder(products: [[String: Any]], totalAmount: Double, payment: PaymentTypes, info: String?, address: String)
    case getOrders(from: String?, to: String?)
    case cancelOrder(orderId: Int)
}

extension APIPoint: EndPointType {
    var path: String {
        switch self {
        case .connect:
            return "/api/v1/entrance/connect"
        case .categories:
            return "/api/v1/goods/categories"
        case .category(let id):
            return "/admin/v1/categories/\(id)"
        case .subCategory(let id):
            return "/admin/v1/subcategories/\(id)"
        case .product(let id):
            return "/admin/v1/products/\(id)"
        case .districts:
            return "/api/v1/entrance/locations/coverage"
        case .findDistrict:
            return "/api/v1/entrance/locations/findDistrict"
        case .checkPhoneNumber:
            return "/api/v1/entrance/checkPhoneNumber"
        case .checkSmsCode:
            return "/api/v1/entrance/checkSmsCode"
        case .resendSms:
            return "/api/v1/entrance/resendSms"
        case .getOrders:
            return "/api/v1/orders"
        case .createOrder:
            return "/api/v1/orders/createOrder"
        case .cancelOrder(let orderId):
            return "/api/v1/orders/\(orderId)/cancel"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .connect, .categories, .districts, .findDistrict, .checkPhoneNumber, .checkSmsCode, .resendSms, .getOrders, .cancelOrder:
            return .post
        case .createOrder:
            return .put
        default:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .categories(let districtId, let hash):
            return [
                "districtId": districtId,
                "hash": hash
            ]
        case .findDistrict(let latitude, let longitude, let address):
            return [
                "point": [
                  "latitude": latitude,
                  "longitude": longitude
                ],
                "address": address
            ]
        case .checkPhoneNumber(let phone, let transactionId):
            return [
                "phoneNumber": phone,
                "transactionId": transactionId
            ]
        case .checkSmsCode(let sms, let transactionId):
            return [
                "sms": sms,
                "transactionId": transactionId
            ]
        case .resendSms(let transactionId):
            return [
                "transactionId": transactionId
            ]
        case .getOrders(let from, let to):
            return [
                "from": from,
                "to": to
            ]
        case .createOrder(let products, let totalAmount, let payment, let info, let address):
            return [
                "products": products,
                "totalAmount": totalAmount,
                "payment": [
                    "type": payment.rawValue,
                    "info": info
                ],
                "address": address,
                "districtId": ModuleUserDefaults.getDistrctId()
            ]
        default:
            return nil
        }
    }
    
    var encoding: Encoder.Encoding {
        switch self {
        default:
            return .jsonEncoding
        }
    }
    
    var additionalHeaders: HTTPHeaders? {
        switch self {
        case .connect:
            return [
                "platform_type": "IOS",
                "platform_version": UIDevice.current.systemVersion,
                "app_version": Bundle.main.releaseVersionNumber ?? "",
                "app_build": Bundle.main.buildVersionNumber ?? "",
                "device_brand": "Apple",
                "device_model": UIDevice.modelName,
                "install_id": ModuleUserDefaults.getUUID()
            ]
        default:
            return nil
        }
    }
    
    var baseURL: URL {
        return URL(string: "http://3.134.243.12:8080")!
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .connect:
            return [:]
        default:
            return [
                "installId": ModuleUserDefaults.getUUID()
            ]
        }
    }
}
