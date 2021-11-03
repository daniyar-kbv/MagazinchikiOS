//
//  CartVIew.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CartView: UIView {
    lazy var topBrush: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .white
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: StaticSize.s100, trailing: 0)
        view.axis = .vertical
        view.spacing = StaticSize.s10
        return view
    }()
    
    lazy var topTitle: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .systemFont(ofSize: StaticSize.s22, weight: .bold)
        view.textColor = .customTextBlack
        view.text = "Заказ будет доставлен за 15 минут по адресу:"
        return view
    }()
    
    lazy var addressView: AddressView = {
        let view = AddressView()
        view.profileButton.isHidden = true
        view.withAddress = true
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.customReuseIdentifier)
        view.rowHeight = StaticSize.s1 * 110
        view.separatorStyle = .none
        view.isScrollEnabled = false
        return view
    }()
    
    lazy var tableTopLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    lazy var sumView: SumView = {
        let view = SumView()
        view.setNames("Итого", "Скидка", "Промокод")
        view.setValues("\((AppShared.sharedInstance.cart.totalPrice ?? 0).formattedWithSeparator) ₸", "\((Double(AppShared.sharedInstance.cart.totalPrice ?? 0) * 0.1).formattedWithSeparator) ₸", "- 10%")
        return view
    }()
    
    lazy var paymentTypeButton: CustomCartBottomButton = {
        let view = CustomCartBottomButton()
        view.setName(text: "Вид оплаты")
        view.setBottom(text: "Наличными")
        return view
    }()
    
    lazy var promocodeButton: CustomCartBottomButton = {
        let view = CustomCartBottomButton()
        view.setName(text: "Промокод")
        view.setBottom(text: "123456")
        view.isHidden = true
        return view
    }()
    
    lazy var bottomButton: CustomButtonTwoText = {
        let view = CustomButtonTwoText()
        view.setLeftTitle(text: "Заказать")
        view.setRightTitle(text: "3 594 ₸")
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
        addSubViews([topBrush, mainScrollView])
        
        topBrush.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(5)
            $0.width.equalTo(45)
            $0.centerX.equalToSuperview()
        })
        
        mainScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true;
        mainScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: StaticSize.s40).isActive = true;
        mainScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true;
        mainScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true;

        mainScrollView.addSubview(mainStackView)

        mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true;
        mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true;
        mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor).isActive = true;
        mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true;
        mainStackView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor).isActive = true;
        
        mainStackView.addArrangedSubViews([topTitle, addressView, tableView, sumView, paymentTypeButton, promocodeButton])
        
        topTitle.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        paymentTypeButton.snp.makeConstraints({
            $0.height.equalTo(StaticSize.s50)
        })
        
        promocodeButton.snp.makeConstraints({
            $0.height.equalTo(StaticSize.s50)
        })
        
        addSubViews([tableTopLine, bottomButton])
        
        tableTopLine.snp.makeConstraints({
            $0.bottom.equalTo(tableView.snp.top)
            $0.left.right.equalTo(tableView)
            $0.height.equalTo(0.5)
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.s15)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
}
