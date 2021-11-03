//
//  OrderFormingViewModel.swift
//  Samokat
//
//  Created by Daniyar on 8/6/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import RxSwift

class OrderFormingViewModel {
    let disposeBag  = DisposeBag()
    
    var data = PublishSubject<GeneralData>()
    var errorSubject = PublishSubject<String>()
    
    var error: String? {
        didSet {
            if let error = error {
                DispatchQueue.global(qos: .background).async {
                    self.errorSubject.onNext(error)
                }
            }
        }
    }
    
    var response: GeneralResponse? {
        didSet {
            if let data = response?.data {
                DispatchQueue.global(qos: .background).async {
                    self.data.onNext(data)
                }
            }
        }
    }
    
    func cancelOrder(orderId: Int){
        SpinnerView.showSpinnerView()
        APIManager.shared.cancelOrder(orderId: orderId){ error, response in
            SpinnerView.removeSpinnerView()
            guard let response = response else {
                self.error = error
                return
            }
            self.response = response
        }
    }
}

