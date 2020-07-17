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
    
    func getCategories(completion:@escaping(_ error:String?,_ module:CategoriesResponse?)->()) {
        router.request(.categories) {data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(error?.localizedDescription, nil)
                return
            }
            let result = self.handleNetworkResponse(response)
            switch result {
            case.success:
                guard let responseData = data else {
                    completion(NetworkResponse.noData.rawValue,nil)
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(CategoriesResponse.self, from: responseData)
                    completion("ok", apiResponse)
                }
                catch {
                    print(error)
                    completion(NetworkResponse.unableToDecode.rawValue,nil)
            }
            case.failure(let error):
                completion(error,nil)
            }
        }
    }
    
    func getCategory(id: Int, completion:@escaping(_ error:String?,_ module:CategoryResponse?)->()) {
        router.request(.category(id: id)) {data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(error?.localizedDescription, nil)
                return
            }
            let result = self.handleNetworkResponse(response)
            switch result {
            case.success:
                guard let responseData = data else {
                    completion(NetworkResponse.noData.rawValue,nil)
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(CategoryResponse.self, from: responseData)
                    completion("ok", apiResponse)
                }
                catch {
                    print(error)
                    completion(NetworkResponse.unableToDecode.rawValue,nil)
            }
            case.failure(let error):
                completion(error,nil)
            }
        }
    }
    
    func getSubCategory(id: Int, completion:@escaping(_ error:String?,_ module:SubCategoryResponse?)->()) {
        router.request(.subCategory(id: id)) {data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(error?.localizedDescription, nil)
                return
            }
            let result = self.handleNetworkResponse(response)
            switch result {
            case.success:
                guard let responseData = data else {
                    completion(NetworkResponse.noData.rawValue,nil)
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(SubCategoryResponse.self, from: responseData)
                    completion("ok", apiResponse)
                }
                catch {
                    print(error)
                    completion(NetworkResponse.unableToDecode.rawValue,nil)
            }
            case.failure(let error):
                completion(error,nil)
            }
        }
    }
    
    func getProduct(id: Int, completion:@escaping(_ error:String?,_ module:ProductResponse?)->()) {
        router.request(.product(id: id)) {data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(error?.localizedDescription, nil)
                return
            }
            let result = self.handleNetworkResponse(response)
            switch result {
            case.success:
                guard let responseData = data else {
                    completion(NetworkResponse.noData.rawValue,nil)
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(ProductResponse.self, from: responseData)
                    completion("ok", apiResponse)
                }
                catch {
                    print(error)
                    completion(NetworkResponse.unableToDecode.rawValue,nil)
            }
            case.failure(let error):
                completion(error,nil)
            }
        }
    }
    
    func checkPhoneNumber(phone: String, completion:@escaping(_ error:String?,_ module: PhoneResponse?)->()) {
        router.request(.checkPhoneNumber(phone: phone)) {data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(error?.localizedDescription, nil)
                return
            }
            let result = self.handleNetworkResponse(response)
            switch result {
            case.success:
                guard let responseData = data else {
                    completion(NetworkResponse.noData.rawValue,nil)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                                        
                                        print(jsonData)
                    let apiResponse = try JSONDecoder().decode(PhoneResponse.self, from: responseData)
                    if apiResponse.data == nil{
                        do {
                            let apiResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                            completion(apiResponse.error?.title, nil)
                        } catch {
                            completion(NetworkResponse.unableToDecode.rawValue,nil)
                        }
                    }
                    completion(nil, apiResponse)
                }
                catch {
                    completion(NetworkResponse.unableToDecode.rawValue,nil)
                }
            case.failure(let error):
                completion(error,nil)
            }
        }
    }
    
    func checkSmsCode(sms: String, transactionId: String, completion:@escaping(_ error:String?,_ module: CheckSmsResponse?)->()) {
        router.request(.checkSmsCode(sms: sms, transactionId: transactionId)) {data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(error?.localizedDescription, nil)
                return
            }
            let result = self.handleNetworkResponse(response)
            switch result {
            case.success:
                guard let responseData = data else {
                    completion(NetworkResponse.noData.rawValue,nil)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    print(jsonData)
                    let apiResponse = try JSONDecoder().decode(CheckSmsResponse.self, from: responseData)
                    if apiResponse.data == nil{
                        do {
                            let apiResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                            completion(apiResponse.error?.title, nil)
                        } catch {
                            completion(NetworkResponse.unableToDecode.rawValue,nil)
                        }
                    }
                    completion(nil, apiResponse)
                }
                catch {
                    completion(NetworkResponse.unableToDecode.rawValue,nil)
                }
            case.failure(let error):
                completion(error,nil)
            }
        }
    }
    
    func resendSms(transactionId: String, completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.resendSms(transactionId: transactionId)) {data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(error?.localizedDescription, nil)
                return
            }
            let result = self.handleNetworkResponse(response)
            switch result {
            case.success:
                guard let responseData = data else {
                    completion(NetworkResponse.noData.rawValue,nil)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    if let myJson = jsonData as? [String: Any]{
                        if myJson["data"] != nil{
                            completion(nil, true)
                        }
                    }
                    let apiResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                    completion(apiResponse.error?.title, nil)
                }
                catch {
                    completion(NetworkResponse.unableToDecode.rawValue,nil)
                }
            case.failure(let error):
                completion(error,nil)
            }
        }
    }
    
    let router = MyRouter<APIPoint>()
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
            switch response.statusCode {
            case 200...500: return .success
            case 422: return .failure(NetworkResponse.badRequest.rawValue)
    //        case 423...500: return .failure(NetworkResponse.authenticationError.rawValue)
            case 500...599: return .failure(NetworkResponse.badRequest.rawValue)
            case 600: return .failure(NetworkResponse.outdated.rawValue)
            case 403: return .failure(NetworkResponse.unauthorized.rawValue)
            default: return .failure(NetworkResponse.failed.rawValue)
            }
        }
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case unauthorized
}
