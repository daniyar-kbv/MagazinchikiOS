//
//  ProductDetailViewModel.swift
//  Samokat
//
//  Created by Daniyar on 7/15/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import RxSwift

class ProductDetailViewModel {
    let disposeBag  = DisposeBag()
    
    var product: PublishSubject<Product>
    
    var response: ProductResponse? {
        didSet {
            if let product = response?.data?.product {
                DispatchQueue.global(qos: .background).async {
                    self.product.onNext(product)
                }
            }
        }
    }
    
    init(id: Int){
        self.product = PublishSubject<Product>()
        SpinnerView.showSpinnerView()
        APIManager.shared.getProduct(id: id) { error, response in
            SpinnerView.removeSpinnerView()
            self.response = response
        }
    }
}
