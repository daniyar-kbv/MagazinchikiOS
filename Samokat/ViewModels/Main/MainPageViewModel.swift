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
    var loadView: UIView?
    
    var response: CategoriesResponse? {
        didSet {
            if let data = response?.data, let categories = data.categories {
                DispatchQueue.global(qos: .background).async {
                    ModuleUserDefaults.setCategories(data: data)
                    AppShared.sharedInstance.categories = categories
                }
            }
        }
    }
    
    func getCategories(){
        guard let districtId = ModuleUserDefaults.getDistrctId() else { return }
        SpinnerView.showSpinnerView(view: loadView)
        APIManager.shared.getCategories(districtId: districtId, hash: nil){ error, response in
            SpinnerView.removeSpinnerView()
            guard let response = response else {
                if let loadView = self.loadView {
                    if let error = error{
                        ErrorView.addToView(view: loadView, text: error, withName: false, disableScroll: true)
                    } else {
                        ErrorView.addToView(view: loadView, withName: false, disableScroll: true)
                    }
                }
                return
            }
            self.response = response
        }
    }
}
