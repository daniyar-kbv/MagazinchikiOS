//
//  AppShared.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AppShared {
    static let sharedInstance = AppShared()
    
    var keyWindow: UIWindow?
    var navigationController: UINavigationController!
    lazy var noInternetViewController = NoInternetViewController()
        
//    MARK: - Data
    
    lazy var categoriesSubject = PublishSubject<[Category]>()
    var categories: [Category]?{
        didSet {
            guard let categories = categories else { return }
            categoriesSubject.onNext(categories)
        }
    }
    var subCategories: [SubCategory]?
    
//    MARK: - For filters
    
    var selectedFilterSubject = PublishSubject<Int>()
    var selectedFilter: Int? {
        didSet {
            guard let selectedFilter = selectedFilter else { return }
            DispatchQueue.global(qos: .background).async {
                self.selectedFilterSubject.onNext(selectedFilter)
            }
            if let onSelect = onSelectFilter{
                onSelect()
            }
        }
    }
    var topFilterView = TopFilterView()
    var onSelectFilter: (()->())?
    
//    MARK: - Cart
    
    var cartSubject = PublishSubject<Cart>()
    var cart: Cart!
    
    lazy var addressSubject = PublishSubject<Address>()
    var address: Address? {
        didSet {
            guard let address = address else { return }
            addressSubject.onNext(address)
        }
    }
    
    lazy var selectedCategory = PublishSubject<Int>()
    
    
    var tags: [Tag]?
}

extension AppShared {
    func findProduct(id: Int) -> Product? {
        guard let categories = categories else { return nil }
        for category in categories {
            if let product = category.getProduct(id: id) {
                return product
            }
        }
        return nil
    }
    
    func searchProducts(text: String) -> [Product] {
        var products: [Product] = []
        guard let categories = categories else { return [] }
        for category in categories {
            products.append(contentsOf: category.search(text: text))
        }
        return products
    }
    
    func checkCategories() {
        APIManager.shared.getCategories(districtId: ModuleUserDefaults.getDistrctId() ?? 0, hash: ModuleUserDefaults.getHash()) { error, response in
            guard let categories = response?.data?.categories, let data = response?.data else { return }
            DispatchQueue.main.async {
                switch response?.data?.status{
                case "NOT_MODIFIED":
                    self.categories = ModuleUserDefaults.getCategories()?.categories
                case "MODIFIED":
                    self.categories = categories
                    ModuleUserDefaults.setCategories(data: data)
                default:
                    break
                }
            }
        }
    }
}
