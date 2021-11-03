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
    lazy var disposeBag = DisposeBag()
    lazy var detailView = ProductDetailView()
    var product: Product? {
        didSet {
            detailView.product = product
        }
    }
    
    required init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.toCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        bind()
    }
    
    override func loadView() {
        super.loadView()
        
        view = detailView
    }
    
    func bind() {
        AppShared.sharedInstance.categoriesSubject.subscribe(onNext: { categories in
            DispatchQueue.main.async {
                if let id = self.product?.id, let product = AppShared.sharedInstance.findProduct(id: id){
                    self.product = product
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
            }).disposed(by: disposeBag)
    }
    
    @objc func addToCart(){
        guard let product = product else { return }
        AppShared.sharedInstance.cart.change(product: product, type: .plus)
        dismiss(animated: true, completion: nil)
    }
}
