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
    
    var categories: [Category]?
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
}
