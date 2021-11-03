//
//  CartViewModel.swift
//  Samokat
//
//  Created by Daniyar on 8/2/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import RxSwift

class CartViewModel {
    let disposeBag  = DisposeBag()
    
    var orderId = PublishSubject<Int>()
    
    var response: CreateOrderResponse? {
        didSet {
            if let id = response?.data?.orderId {
                DispatchQueue.global(qos: .background).async {
                    self.orderId.onNext(id)
                }
            }
        }
    }
    
    func createOrder(payment: PaymentTypes){
        let cart = AppShared.sharedInstance.cart
        var products: [[String: Any]] = []
        for item in cart?.items ?? []{
            if let id = item.product?.id, let price = item.product?.price?.currentPrice, let count = item.count{
                products.append([
                    "productId": id,
                    "price": price,
                    "quantity": count
                ])
            }
        }
        if let total = cart?.totalPrice, let address = AppShared.sharedInstance.address?.getAddress(){
            SpinnerView.showSpinnerView()
            APIManager.shared.createOrder(products: products, totalAmount: total, payment: payment, info: nil, address: address){ error, response in
                SpinnerView.removeSpinnerView()
                self.response = response
            }
        }
    }
}
