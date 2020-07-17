
//  CartView.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class CustomCartView: UIButton {
    lazy var disposeBag = DisposeBag()
    
    lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s20, weight: .regular)
        label.textColor = .white
        label.text = "Итого: \((AppShared.sharedInstance.cart.totalPrice ?? 0).formattedWithSeparator) ₸"
        return label
    }()
    
    lazy var cartButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "smallFigureUp"), for: .normal)
        view.setTitle("Корзина", for: .normal)
        view.setTitleColor(.customTextBlack, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: StaticSize.s14, weight: .regular)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundImage(UIImage(named: "figureUp"), for: .normal)
        addTarget(self, action: #selector(openCart), for: .touchUpInside)
        
        setUp()
        bind()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        AppShared.sharedInstance.cartSubject.subscribe(onNext: {cart in
            self.setText(text: "Итого: \((cart.totalPrice ?? 0).formattedWithSeparator) ₸")
            self.show(cart.totalPrice ?? 0 > 0)
        }).disposed(by: disposeBag)
    }
    
    func setUp(){
        addSubViews([sumLabel, cartButton])
        
        cartButton.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.s10)
            $0.centerY.equalToSuperview()
        })
        
        sumLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.s20)
            $0.centerY.equalToSuperview()
        })
    }
    
    func setText(text: String){
        sumLabel.text = text
    }
    
    @objc func openCart(){
        if let vc = viewContainingController(){
            vc.present(CartViewController(), animated: true, completion: nil)
        }
    }
    
    func show(_ show: Bool){
        guard let superview = self.superview else { return }
        if show{
            self.snp.updateConstraints({
                $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.s15)
            })
        } else {
            self.snp.updateConstraints({
                $0.bottom.equalToSuperview().offset(StaticSize.buttonHeight)
            })
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            superview.layoutIfNeeded()
        })
    }
}
