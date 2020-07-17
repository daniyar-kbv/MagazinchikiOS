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
    case categories
    case category(id: Int)
    case subCategory(id: Int)
    case product(id: Int)
    case checkPhoneNumber(phone: String)
    case checkSmsCode(sms: String, transactionId: String)
    case resendSms(transactionId: String)
}

extension APIPoint: EndPointType {
    var path: String {
        switch self {
        case .categories:
            return "/admin/v1/categories"
        case .category(let id):
            return "/admin/v1/categories/\(id)"
        case .subCategory(let id):
            return "/admin/v1/subcategories/\(id)"
        case .product(let id):
            return "/admin/v1/products/\(id)"
        case .checkPhoneNumber:
            return "/api/v1/entrance/checkPhoneNumber"
        case .checkSmsCode:
            return "/api/v1/entrance/checkSmsCode"
        case .resendSms:
            return "/api/v1/entrance/resendSms"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .checkPhoneNumber, .checkSmsCode, .resendSms:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .checkPhoneNumber(let phone):
            return [
                "phoneNumber": phone
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
        case .checkPhoneNumber, .checkSmsCode, .resendSms:
            return [
                "installId": "2"
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
        default:
            return [
            ]
        }
    }
}
