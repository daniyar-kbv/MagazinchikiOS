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
    var viewModel: ProductsViewModel?
    var categoryId: Int?
    
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
        if let id = categoryId{
            viewModel = ProductsViewModel(id: id)
        }
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        productsView.productsCollection.closeFilters()
    }
    
    func bind(){
        if let viewModel = viewModel{
            viewModel.category.subscribe(onNext: { category in
                DispatchQueue.main.async {
                    self.productsView.productsCollection.category = category
                    AppShared.sharedInstance.subCategories = category.subCategories
                }
                }).disposed(by: disposeBag)
            viewModel.subCategory?.subscribe(onNext: { category in
                DispatchQueue.main.async {
                    self.productsView.productsCollection.subCategory = category
                }
                }).disposed(by: disposeBag)
        }
        AppShared.sharedInstance.selectedFilterSubject.subscribe(onNext: {[weak self] selected in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.viewModel?.getSubCategory(id: selected)
                self.productsView.productsCollection.reloadData()
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
