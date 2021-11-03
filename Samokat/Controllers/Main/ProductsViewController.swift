//
//  ProductsViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ProductsViewController: UIViewController {
    lazy var disposeBag = DisposeBag()
    lazy var productsView = ProductsView()
    
    override func loadView() {
        super.loadView()
        
        view = productsView
    }
    
    deinit {
        AppShared.sharedInstance.selectedFilter = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.delegate = self
        
        addBackButton()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        productsView.productsCollection.closeFilters()
    }
    
    func bind(){
        AppShared.sharedInstance.selectedFilterSubject.subscribe(onNext: {[weak self] selected in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.productsView.productsCollection.filteredProducts = self.productsView.productsCollection.subCategory?.filterByTag(tagId: selected)
            }
        }).disposed(by: disposeBag)
        AppShared.sharedInstance.categoriesSubject.subscribe(onNext: { categories in
            DispatchQueue.main.async {
                guard let categoryId = self.productsView.productsCollection.subCategory?.categoryId else { return }
                if let found = categories.first(where: {
                    $0.id == categoryId
                }){
                    guard let subCategoryId = self.productsView.productsCollection.subCategory?.id else { return }
                    if let subCategory = found.getSubcategory(id: subCategoryId){
                        if let selectedFilter = AppShared.sharedInstance.selectedFilter {
                            if !(subCategory.tags?.contains(where: {
                                $0.id == selectedFilter
                            }) ?? false) {
                                AppShared.sharedInstance.selectedFilter = subCategory.tags?.first?.id
                            }
                            self.productsView.productsCollection.subCategory = subCategory
                        }
                    }
                }
                self.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
}

extension ProductsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is MainPageViewController{
            AppShared.sharedInstance.navigationController.isNavigationBarHidden = true
            AppShared.sharedInstance.navigationController.delegate = nil
        }
    }
}
