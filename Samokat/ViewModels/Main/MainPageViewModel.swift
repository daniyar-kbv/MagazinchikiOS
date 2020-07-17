//
//  MainPageViewModel.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import RxSwift

class MainPageViewModel {
    let disposeBag  = DisposeBag()
    
    var categories: PublishSubject<[Category]>
    
    var response: CategoriesResponse? {
        didSet {
            if let categories = response?.data?.categories {
                DispatchQueue.global(qos: .background).async {
                    self.categories.onNext(categories)
                    AppShared.sharedInstance.categories = categories
                }
            }
        }
    }
    
    init(){
        self.categories = PublishSubject<[Category]>()
        SpinnerView.showSpinnerView()
        APIManager.shared.getCategories(){ error, response in
            SpinnerView.removeSpinnerView()
            self.response = response
        }
    }
}
