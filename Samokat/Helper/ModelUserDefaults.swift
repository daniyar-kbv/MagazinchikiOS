//
//  ModelUserDefaults.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

struct ModuleUserDefaults {
    static func setToken(token:String) {
        let defaults = UserDefaults.standard
        defaults.setValue(token, forKey: "token")
    }
    
    static func getToken() -> String? {
        let defaults = UserDefaults.standard
        let token = defaults.value(forKey: "token") as? String
        return token
    }
    
    static func clear(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    static func setCart(cart: Cart){
        let defaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: cart)
        defaults.set(encodedData, forKey: "cart")
        defaults.synchronize()
    }
    
    static func getCart() -> Cart?{
        let defaults = UserDefaults.standard
        let decoded  = defaults.data(forKey: "cart")
        if decoded != nil{
            let decodedCount = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? Cart
            return decodedCount
        } else {
            return nil
        }
    }
}
