//
//  BillVIew.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BillView: UIView {
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

    lazy var shareButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "share"), for: .normal)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s30, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "Чек"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var billView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "billRect")
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = StaticSize.s5
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var billTopView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "billTop")
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var paidLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s1 * 24, weight: .medium)
        label.textColor = .white
        label.text = "Оплачено"
        return label
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .medium)
        label.textColor = .customLightGray
        label.text = "№ Заказа"
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .medium)
        label.textColor = .customLightGray
        label.text = "Дата платежа"
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .medium)
        label.textColor = .customLightGray
        label.text = "Вид оплаты"
        return label
    }()
    
    lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .medium)
        label.textColor = .customLightGray
        label.text = "Сумма платежа"
        return label
    }()
    
    lazy var leftStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [numberLabel, dateLabel, typeLabel, sumLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .leading
        view.spacing = StaticSize.s8
        return view
    }()
    
    lazy var numberValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .regular)
        label.textColor = .customTextBlack
        label.text = "Заказ № 28149495"
        return label
    }()
    
    lazy var dateValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .regular)
        label.textColor = .customTextBlack
        label.text = "19.07.2020, 11:09"
        return label
    }()
    
    lazy var typeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .regular)
        label.textColor = .customTextBlack
        label.text = "Банковской картой"
        return label
    }()
    
    lazy var sumValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .regular)
        label.textColor = .customTextBlack
        label.text = "3 005 KZT"
        return label
    }()
    
    lazy var rightStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [numberValueLabel, dateValueLabel, typeValueLabel, sumValueLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .leading
        view.spacing = StaticSize.s8
        return view
    }()
    
    lazy var mainStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftStack, rightStack])
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .fill
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
        addSubViews([topBrush, backButton, shareButton, titleLabel, billView])
        
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
        
        shareButton.snp.makeConstraints({
            $0.right.top.equalToSuperview().inset(StaticSize.s15)
            $0.size.equalTo(StaticSize.s30)
        })
        
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(backButton.snp.bottom).offset(StaticSize.s15)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        billView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.s20)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        billView.addSubViews([billTopView, mainStack])

        billTopView.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
        })

        billTopView.addSubViews([paidLabel])
        paidLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.s15)
        })

        mainStack.snp.makeConstraints({
            $0.top.equalTo(billTopView.snp.bottom).offset(StaticSize.s20)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.bottom.equalToSuperview().offset(-StaticSize.s30)
        })
    }
}
