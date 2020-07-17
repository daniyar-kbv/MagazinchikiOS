//
//  ProductDetailViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ProductDetailViewController: UIViewController {
    lazy var detailView = ProductDetailView()
    lazy var disposeBag = DisposeBag()
    var product: Product? {
        didSet {
            detailView.product = product
        }
    }
    var productId: Int
    var viewModel: ProductDetailViewModel?
    
    required init(id: Int){
        self.productId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.toCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        viewModel = ProductDetailViewModel(id: productId)
        bind()
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.product.subscribe(onNext: { product in
            DispatchQueue.main.async {
                self.product = product
            }
        }).disposed(by: disposeBag)
    }
    
    override func loadView() {
        super.loadView()
        
        view = detailView
    }
    
    @objc func addToCart(){
        guard let product = product else { return }
        AppShared.sharedInstance.cart.change(product: product, type: .plus)
        dismiss(animated: true, completion: nil)
    }
}
