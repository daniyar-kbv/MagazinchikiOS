//
//  OrderDetailView.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class OrderDetailView: UIView{
    lazy var rowHeight = StaticSize.s1 * 65
    
    lazy var topBrush: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "backButtonSmall"), for: .normal)
        return view
    }()
    
    lazy var billButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "bill"), for: .normal)
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
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: StaticSize.s15, leading: 0, bottom: StaticSize.s100, trailing: 0)
        view.axis = .vertical
        view.spacing = StaticSize.s15
        return view
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s30, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "Заказ №28149495"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var creationDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "Оформлен: 25 июня, 12:05"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var currentStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "Отменен"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var datesView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var inOrderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customLightGray
        label.text = "В заказе"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.register(OrderDetailCell.self, forCellReuseIdentifier: OrderDetailCell.customReuseIdentifier)
        view.rowHeight = rowHeight
        view.isScrollEnabled = false
        return view
    }()
    
    lazy var tableContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customLightGray
        label.text = "Итого"
        return label
    }()
    
    lazy var sumValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s20, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "17 005 ₸"
        return label
    }()
    
    lazy var sumView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [sumLabel, sumValueLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .leading
        view.spacing = StaticSize.s8
        return view
    }()
    
    lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customLightGray
        label.text = "Скидка"
        return label
    }()
    
    lazy var discountValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s20, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "1 589 ₸"
        return label
    }()
    
    lazy var discountView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [discountLabel, discountValueLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .leading
        view.spacing = StaticSize.s8
        return view
    }()
    
    lazy var priceView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var paymentTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customLightGray
        label.text = "Оплата"
        return label
    }()
    
    lazy var paymentTypeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s20, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "Банковская карта"
        return label
    }()
    
    lazy var cardView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cardSmall")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .customTextBlack
        return view
    }()
    
    lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .regular)
        label.textColor = .customTextBlack
        label.text = "•••• 9858"
        return label
    }()
    
    lazy var cardValueView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var paymentTypeView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var paymentTypeValueView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [paymentTypeValueLabel, cardValueView])
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = StaticSize.s10
        view.alignment = .fill
        return view
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customLightGray
        label.text = "Адрес"
        return label
    }()
    
    lazy var addressValueLabel: CustomLabelWithoutPadding = {
        let label = CustomLabelWithoutPadding()
        label.font = .systemFont(ofSize: StaticSize.s20, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "Орбита 1 микрорайон, дом 38, кв. 94"
        return label
    }()
    
    lazy var addressView: UIView = {
        let view = UIView()
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
        addSubViews([topBrush, backButton, billButton, mainScrollView])
        
        topBrush.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(5)
            $0.width.equalTo(45)
            $0.centerX.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({
            $0.left.top.equalToSuperview().offset(StaticSize.s15)
            $0.size.equalTo(StaticSize.s30)
        })
        
        billButton.snp.makeConstraints({
            $0.right.top.equalToSuperview().inset(StaticSize.s15)
            $0.size.equalTo(StaticSize.s30)
        })
        
        mainScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true;
        mainScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: StaticSize.s46).isActive = true;
        mainScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true;
        mainScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true;

        mainScrollView.addSubview(mainStackView)

        mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true;
        mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true;
        mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor).isActive = true;
        mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true;
        mainStackView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor).isActive = true;
        
        mainStackView.addArrangedSubViews([numberLabel, datesView, tableContainer, priceView, paymentTypeView, addressView])
        
        numberLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.s15)
        })
        
        datesView.addSubViews([creationDateLabel, currentStatusLabel])
        creationDateLabel.snp.makeConstraints({
            $0.top.left.equalToSuperview()
        })
        
        currentStatusLabel.snp.makeConstraints({
            $0.top.equalTo(creationDateLabel.snp.bottom).offset(StaticSize.s5)
            $0.bottom.equalToSuperview()
        })
        
        tableContainer.addSubViews([inOrderLabel, tableView])
        inOrderLabel.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(inOrderLabel.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
        
        priceView.addSubViews([sumView, discountView])
        sumView.snp.makeConstraints({
            $0.top.left.bottom.equalToSuperview()
        })
        
        discountView.snp.makeConstraints({
            $0.left.equalTo(sumView.snp.right).offset(StaticSize.s30)
            $0.top.bottom.equalToSuperview()
        })
        
        paymentTypeView.addSubViews([paymentTypeLabel, paymentTypeValueView])
        
        paymentTypeLabel.snp.makeConstraints({
            $0.left.top.equalToSuperview()
        })
        
        paymentTypeValueView.snp.makeConstraints({
            $0.top.equalTo(paymentTypeLabel.snp.bottom).offset(StaticSize.s8)
            $0.left.right.bottom.equalToSuperview()
        })
        
        cardValueView.addSubViews([cardView, cardNumberLabel])
        cardView.snp.makeConstraints({
            $0.left.centerY.equalToSuperview()
            $0.width.equalTo(StaticSize.s28)
            $0.height.equalTo(StaticSize.s18)
        })
        
        cardNumberLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalTo(cardView.snp.right).offset(StaticSize.s5)
        })
        
        addressView.addSubViews([addressLabel, addressValueLabel])
        addressLabel.snp.makeConstraints({
            $0.top.left.equalToSuperview()
        })
        
        addressValueLabel.snp.makeConstraints({
            $0.top.equalTo(addressLabel.snp.bottom).offset(StaticSize.s8)
            $0.left.right.bottom.equalToSuperview()
        })
    }
}
