//
//  ToCartButton.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ToCartButton: UIButton {
    lazy var disposeBag = DisposeBag()
    var product: Product? {
        didSet {
            if let productId = product?.id, let count = AppShared.sharedInstance.cart.getItem(productId: productId)?.count{
                self.count = count
            }
        }
    }
    var withCart: Bool = true
    var count: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.minusButton.isHidden = self.count == 0 && self.withCart
                self.plusButton.isHidden = self.count == 0 && self.withCart
                if self.count == 0 && self.withCart{
                    self.setTitle("В корзину", for: .normal)
                } else {
                    self.setTitle("\(self.count) шт", for: .normal)
                }
            }
        }
    }
    
    lazy var minusButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "circleGreen"), for: .normal)
        view.setImage(UIImage(named: "minus"), for: .normal)
        view.addTarget(self, action: #selector(minusCount), for: .touchUpInside)
        view.isHidden = self.count == 0 && self.withCart
        return view
    }()
    
    lazy var plusButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "circleGreen"), for: .normal)
        view.setImage(UIImage(named: "plus"), for: .normal)
        view.addTarget(self, action: #selector(plusCount), for: .touchUpInside)
        view.isHidden = withCart
        return view
    }()
    
    required init(count: Int = 0, withCart: Bool = true) {
        super.init(frame: .zero)
        self.count = count
        self.withCart = withCart
        
        if count == 0 && withCart{
            self.setTitle("В корзину", for: .normal)
        } else {
            self.setTitle("\(count) шт", for: .normal)
        }
        setBackgroundImage(UIImage(named: "roundFigure"), for: .normal)
        setTitleColor(.customGreen, for: .normal)
        titleLabel?.font = .systemFont(ofSize: StaticSize.s13, weight: .medium)
        addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
        setUp()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        AppShared.sharedInstance.cartSubject.subscribe(onNext: { cart in
            if let productId = self.product?.id{
                self.count = cart.getItem(productId: productId)?.count ?? 0
            }
        }).disposed(by: disposeBag)
    }
    
    func setUp(){
        addSubViews([minusButton, plusButton])
        
        minusButton.snp.makeConstraints({
            $0.left.equalTo(StaticSize.s5)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.s1 * 26)
        })
        
        plusButton.snp.makeConstraints({
            $0.right.equalTo(-StaticSize.s5)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.s1 * 26)
        })
    }
    
    @objc func plusCount() {
        count += 1
        if let product = product {
            AppShared.sharedInstance.cart?.change(product: product, type: .plus)
        }
    }
    
    @objc func minusCount() {
        count -= 1
        if let product = product {
            AppShared.sharedInstance.cart?.change(product: product, type: .minus)
        }
    }
    
    @objc func pressed() {
        if count == 0 && withCart{
            plusCount()
        }
    }
}
