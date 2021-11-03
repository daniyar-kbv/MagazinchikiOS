//
//  APIManager.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request<T: Codable>(_ route: EndPoint, returning: T.Type, boolResult: Bool, completion: @escaping(_ error:String?,_ module: T?)->())
}

class MyRouter<EndPoint: EndPointType>: NetworkRouter{
    
    func request<T>(_ route: EndPoint, returning: T.Type, boolResult: Bool = false, completion: @escaping(_ error:String?,_ module: T?)->()) where T : Decodable, T : Encodable {
        let headers = { () -> HTTPHeaders? in
            var headers = route.header
            if let additionalHeaders = route.additionalHeaders{
                for header in additionalHeaders{
                    headers?.updateValue(header.value, forKey: header.key)
                }
            }
            return headers
        }()
        Alamofire.request(route.baseURL.appendingPathComponent(route.path), method: route.httpMethod, parameters: route.parameters, encoding: Encoder.getEncoding(route.encoding), headers: headers).responseData() { response in
            guard let res = response.response else {
                completion(response.error?.localizedDescription, nil)
                return
            }
            let result = self.handleNetworkResponse(res)
            switch result {
            case .success:
                guard let responseData = response.data else {
                    completion(NetworkResponse.noData.rawValue, nil)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    print(jsonData)
                    if let myJson = jsonData as? [String: Any]{
                        if myJson["data"] == nil{
                            do {
                                let apiResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                                completion(apiResponse.error?.title, nil)
                                return
                            } catch {
                                completion(NetworkResponse.unableToDecode.rawValue, nil)
                                return
                            }
                        } else if myJson["data"] != nil && boolResult{
                            do {
                                let mBoolValue = true
                                let boolData = try JSONEncoder().encode(mBoolValue)
                                let apiResponse = try JSONDecoder().decode(T.self, from: boolData)
                                completion(nil, apiResponse)
                                return
                            } catch {
                                completion(NetworkResponse.unableToDecode.rawValue, nil)
                                return
                            }
                        }
                    }
                    let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                    completion(nil, apiResponse)
                }
                catch {
                    completion(NetworkResponse.unableToDecode.rawValue,nil)
                }
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    enum Result<String>{
        case success
        case failure(String)
    }

    enum NetworkResponse:String {
        case success
        case authenticationError = "Вы не авторизованы"
        case badRequest = "Bad request"
        case outdated = "The url you requested is outdated."
        case failed = "Произошла ошибка"
        case noData = "Пустой ответ"
        case unableToDecode = "Мы не смогли лбр"
        case unauthorized
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...500: return .success
//        case 422: return .failure(NetworkResponse.badRequest.rawValue)
//        case 423...500: return .failure(NetworkResponse.authenticationError.rawValue)
//        case 500...599: return .failure(NetworkResponse.badRequest.rawValue)
//        case 600: return .failure(NetworkResponse.outdated.rawValue)
//        case 403: return .failure(NetworkResponse.unauthorized.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
