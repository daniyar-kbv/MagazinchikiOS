//
//  OrderFormingView.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Lottie

class OrderFormingView: UIView {
    lazy var animation: AnimationView = {
        let view = AnimationView(name: "orderAnimation")
        view.loopMode = .loop
        return view
    }()
    
    lazy var text: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s22, weight: .bold)
        label.textColor = .customTextBlack
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "Начинаем формирование\nВашего заказа,\nпожалуйста подождите"
        return label
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [animation, text])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        view.spacing = 0
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "buttonWhite"), for: .normal)
        view.setTitle("Отменить заказ", for: .normal)
        view.setTitleColor(.customGreen, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: StaticSize.s16, weight: .bold)
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
        addSubViews([stack, cancelButton])
        stack.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        
        animation.snp.makeConstraints({
            $0.width.equalTo(StaticSize.s188 * 1.2)
            $0.height.equalTo(StaticSize.s1 * 157 * 1.2)
        })
        
        cancelButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.s15)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
}
