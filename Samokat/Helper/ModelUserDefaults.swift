//
//  ModelUserDefaults.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

struct ModuleUserDefaults {
    static func setIsLoggedIn(_ value: Bool){
        let defaults = UserDefaults.standard
        defaults.setValue(value, forKey: "isLoggedIn")
    }
    
    static func getIsLoggedIn() -> Bool{
        let defaults = UserDefaults.standard
        if let value = defaults.value(forKey: "isLoggedIn"){
            if value as! Int == 1{
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    static func setDistrctId(id: Int) {
        let defaults = UserDefaults.standard
        defaults.setValue(id, forKey: "districtId")
    }
    
    static func getDistrctId() -> Int? {
        let defaults = UserDefaults.standard
        let id = defaults.value(forKey: "districtId") as? Int
        return id
    }
    
    static func setHash(value: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(value, forKey: "hash")
    }
    
    static func getHash() -> String? {
        let defaults = UserDefaults.standard
        let id = defaults.value(forKey: "hash") as? String
        return id
    }
    
    static func setAddress(address: Address) {
        let defaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: address)
        defaults.set(encodedData, forKey: "addressObj")
        defaults.synchronize()
    }
    
    static func getAddress() -> Address? {
        let defaults = UserDefaults.standard
        let decoded  = defaults.data(forKey: "addressObj")
        if decoded != nil{
            let decodedCount = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? Address
            return decodedCount
        } else {
            return nil
        }
    }
    
    static func setCart(cart: Cart) {
        let defaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: cart)
        defaults.set(encodedData, forKey: "cart")
        defaults.synchronize()
    }
    
    static func getCart() -> Cart? {
        let defaults = UserDefaults.standard
        let decoded  = defaults.data(forKey: "cart")
        if decoded != nil{
            let decodedCount = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? Cart
            return decodedCount
        } else {
            return nil
        }
    }
    
    static func setCategories(data: CategoriesData) {
        let defaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: data)
        defaults.set(encodedData, forKey: "categories")
        defaults.synchronize()
    }
    
    static func getCategories() -> CategoriesData? {
        let defaults = UserDefaults.standard
        let decoded  = defaults.data(forKey: "categories")
        if decoded != nil{
            let decodedCount = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? CategoriesData
            return decodedCount
        } else {
            return nil
        }
    }
    
    static func clear(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    static func getUUID() -> String{
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
}
