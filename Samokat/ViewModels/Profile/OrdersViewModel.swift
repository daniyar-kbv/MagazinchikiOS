//
//  OrdersViewModel.swift
//  Samokat
//
//  Created by Daniyar on 8/2/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import RxSwift

class OrdersViewModel {
    let disposeBag  = DisposeBag()
    
    var orders = PublishSubject<[Order]>()
    
    var response: GetOrdersResponse? {
        didSet {
            if let orders = response?.data?.orders {
                DispatchQueue.global(qos: .background).async {
                    self.orders.onNext(orders)
                }
            }
        }
    }
    
    func getOrders(from: Date = Date(timeIntervalSince1970: 1590969600), to: Date = Date()){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let fromStr = formatter.string(from: from)
        let toStr = formatter.string(from: to)
        SpinnerView.showSpinnerView()
        APIManager.shared.getOrders(from: fromStr, to: toStr){ error, response in
            SpinnerView.removeSpinnerView()
            guard error == nil else {
                ErrorView.addToView(view: UIApplication.topViewController()?.view ?? UIView())
                return
            }
            self.response = response
        }
    }
}
