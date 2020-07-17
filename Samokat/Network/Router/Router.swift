//
//  APIManager.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import Alamofire

public typealias NetworkRouterCompletion = (_ data:Data?,_ response:URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
}

class MyRouter<EndPoint: EndPointType>: NetworkRouter{
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let headers = { () -> HTTPHeaders? in
            var headers = route.header
            if let additionalHeaders = route.additionalHeaders{
                for header in additionalHeaders{
                    headers?.add(header)
                }
            }
            return headers
        }()
        AF.request(route.baseURL.appendingPathComponent(route.path), method: route.httpMethod, parameters: route.parameters, encoding: Encoder.getEncoding(route.encoding), headers: headers).responseData() { response in
            completion(response.data, response.response, response.error)
        }
    }
}

