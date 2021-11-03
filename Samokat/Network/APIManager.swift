//
//  APIManager.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

struct APIManager {
    static let shared = APIManager()
    let router = MyRouter<APIPoint>()
    
    func connect(completion:@escaping(_ error:String?,_ module: GeneralResponse?)->()) {
        router.request(.connect, returning: GeneralResponse?.self) { error, response in
            completion(error, response as? GeneralResponse)
        }
    }
    
    func getCategories(districtId: Int, hash: String?, completion:@escaping(_ error:String?,_ module:CategoriesResponse?)->()) {
        router.request(.categories(districtId: districtId, hash: hash), returning: CategoriesResponse?.self) { error, response in
            completion(error, response as? CategoriesResponse)
        }
    }
    
    func getDistricts(completion:@escaping(_ error:String?,_ module: DistrictsResponse?)->()) {
        router.request(.districts, returning: DistrictsResponse?.self) { error, response in
            completion(error, response as? DistrictsResponse)
        }
    }
    
    func findDistrict(latitude: Double, longitude: Double, address: String, completion:@escaping(_ error:String?,_ module: FindDistrictResponse?)->()) {
        router.request(.findDistrict(latitude: latitude, longitude: longitude, address: address), returning: FindDistrictResponse?.self) { error, response in
            completion(error, response as? FindDistrictResponse)
        }
    }
    
    func checkPhoneNumber(phone: String, transactionId: String, completion:@escaping(_ error:String?,_ module: PhoneResponse?)->()) {
        router.request(.checkPhoneNumber(phone: phone, transactionId: transactionId), returning: PhoneResponse?.self) { error, response in
            completion(error, response as? PhoneResponse)
        }
    }
    
    func checkSmsCode(sms: String, transactionId: String, completion:@escaping(_ error:String?,_ module: CheckSmsResponse?)->()) {
        router.request(.checkSmsCode(sms: sms, transactionId: transactionId), returning: CheckSmsResponse?.self) { error, response in
            completion(error, response as? CheckSmsResponse)
        }
    }
    
    func resendSms(transactionId: String, completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.resendSms(transactionId: transactionId), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func createOrder(products: [[String: Any]], totalAmount: Double, payment: PaymentTypes, info: String?, address: String, completion:@escaping(_ error:String?,_ module: CreateOrderResponse?)->()) {
        router.request(.createOrder(products: products, totalAmount: totalAmount, payment: payment, info: info, address: address), returning: CreateOrderResponse?.self) { error, response in
            completion(error, response as? CreateOrderResponse)
        }
    }
    
    func getOrders(from: String?, to: String?, completion:@escaping(_ error:String?,_ module: GetOrdersResponse?)->()) {
        router.request(.getOrders(from: from, to: to), returning: GetOrdersResponse?.self) { error, response in
            completion(error, response as? GetOrdersResponse)
        }
    }
    
    func cancelOrder(orderId: Int, completion:@escaping(_ error:String?,_ module: GeneralResponse?)->()) {
        router.request(.cancelOrder(orderId: orderId), returning: GeneralResponse?.self) { error, response in
            completion(error, response as? GeneralResponse)
        }
    }
}
