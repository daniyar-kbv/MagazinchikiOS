//
//  ProductsView.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ProductsView: UIView {
    lazy var productsCollection: ProductsCollectionView = {
        let view = ProductsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    lazy var cartView: CustomCartView = {
        let view = CustomCartView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubViews([productsCollection, cartView])
        
        productsCollection.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        if AppShared.sharedInstance.cart.items?.count ?? 0 > 0{
            cartView.snp.makeConstraints({
                $0.left.right.equalToSuperview().inset(StaticSize.s15)
                $0.height.equalTo(StaticSize.buttonHeight)
                $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.s15)
            })
        } else {
            cartView.snp.makeConstraints({
                $0.left.right.equalToSuperview().inset(StaticSize.s15)
                $0.height.equalTo(StaticSize.buttonHeight)
                $0.bottom.equalToSuperview().offset(StaticSize.buttonHeight)
            })
        }
    }
}
