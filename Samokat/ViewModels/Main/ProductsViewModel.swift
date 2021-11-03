//
//  ProductsViewModel.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import RxSwift

class ProductsViewModel {
    let disposeBag  = DisposeBag()
    
    var category: PublishSubject<Category>
    var subCategory: PublishSubject<SubCategory>?
    
    var response: CategoryResponse? {
        didSet {
            if let category = response?.data?.category {
                DispatchQueue.global(qos: .background).async {
                    self.category.onNext(category)
                }
            }
        }
    }
    var subCategoryResponse: SubCategoryResponse? {
        didSet {
            if let subCategory = subCategoryResponse?.data?.subCategory {
                DispatchQueue.global(qos: .background).async {
                    self.subCategory?.onNext(subCategory)
                }
            }
        }
    }
    
    init(id: Int) {
        self.category = PublishSubject<Category>()
//        SpinnerView.showSpinnerView()
//        APIManager.shared.getCategory(id: id){ error, response in
//            SpinnerView.removeSpinnerView()
//            self.response = response
//        }
    }
    
    func getSubCategory(id: Int){
        self.subCategory = PublishSubject<SubCategory>()
//        SpinnerView.showSpinnerView()
//        APIManager.shared.getSubCategory(id: id){ error, response in
//            SpinnerView.removeSpinnerView()
//            self.subCategoryResponse = response
//        }
    }
}
