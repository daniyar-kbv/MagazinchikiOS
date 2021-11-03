//
//  Cart.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

class Cart: NSObject, NSCoding {
    var items: [CartItem]?
    var totalPrice: Double?
    
    enum OperationType {
        case plus
        case minus
        case remove
    }
    
    init(items: [CartItem]?, totalPrice: Double? = 0) {
        self.items = items
        self.totalPrice = totalPrice
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let items = aDecoder.decodeObject(forKey: "items") as? [CartItem]
        let totalPrice = aDecoder.decodeObject(forKey: "totalPrice") as? Double
        self.init(items: items, totalPrice: totalPrice)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(items, forKey: "items")
        aCoder.encode(totalPrice, forKey: "totalPrice")
    }
    
    func change(product: Product, type: OperationType){
        guard var items = items else { return }
        var found = false
        for item in items{
            guard var count = item.count else { return }
            if item.product?.id == product.id{
                found = true
                switch type {
                case .plus:
                    item.count = count + 1
                case .minus:
                    item.count = count - 1
                    if item.count == 0 {
                        if let index = items.firstIndex(of: item){
                            self.items?.remove(at: index)
                        }
                    }
                case .remove:
                    if let index = items.firstIndex(of: item){
                        self.items?.remove(at: index)
                    }
                }
            }
        }
        if !found && type == .plus{
            let item = CartItem(product: product, count: 1)
            self.items?.append(item)
        }
        self.reCalculate()
        AppShared.sharedInstance.cartSubject.onNext(self)
        ModuleUserDefaults.setCart(cart: self)
    }
    
    func reCalculate(){
        guard let items = items else { return }
        var price = 0
        for item in items {
            price += (Int(item.product?.price?.currentPrice ?? "") ?? 0) * (item.count ?? 0)
        }
        self.totalPrice = Double(price)
    }
    
    func getItem(productId: Int) -> CartItem? {
        guard let items = items else { return nil }
        for item in items {
            if item.product?.id == productId {
                return item
            }
        }
        return nil
    }
    
    func clear() {
        self.items?.removeAll()
        self.reCalculate()
        AppShared.sharedInstance.cartSubject.onNext(self)
        ModuleUserDefaults.setCart(cart: self)
    }
}

class CartItem: NSObject, NSCoding {
    var product: Product?
    var count: Int?
    
    init(product: Product?, count: Int?) {
        self.product = product
        self.count = count
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let product = aDecoder.decodeObject(forKey: "product") as? Product
        let count = aDecoder.decodeObject(forKey: "count") as? Int
        self.init(product: product, count: count)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(product, forKey: "product")
        aCoder.encode(count, forKey: "count")
    }
}
