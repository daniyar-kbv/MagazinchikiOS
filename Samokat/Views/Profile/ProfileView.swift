//
//  Profile.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ProfileView: UIView {
    lazy var disposeBag = DisposeBag()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s30, weight: .bold)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        label.text = "+7 702 000 00 28"
        return label
    }()
    
    lazy var cardLabel: UIButton = {
        let label = UIButton()
        label.setTitle("Банковская карта", for: .normal)
        label.setTitleColor(.customTextBlack, for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: StaticSize.s20, weight: .medium)
        return label
    }()
    
    lazy var cardImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cardSmall")
        return view
    }()
    
    lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .regular)
        label.textColor = .customLightGray
        label.adjustsFontSizeToFitWidth = true
        label.text = "•••• 9858"
        return label
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    lazy var addressLabel: UIButton = {
        let label = UIButton()
        label.setTitle("Адрес", for: .normal)
        label.setTitleColor(.customTextBlack, for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: StaticSize.s20, weight: .medium)
        return label
    }()
    
    lazy var addressFullLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .regular)
        label.textColor = .customLightGray
        label.adjustsFontSizeToFitWidth = true
        label.text = AppShared.sharedInstance.address?.getAddress()
        return label
    }()
    
    lazy var addressView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var ordersLabel: UIButton = {
        let label = UIButton()
        label.setTitle("Заказы", for: .normal)
        label.setTitleColor(.customTextBlack, for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: StaticSize.s20, weight: .medium)
        return label
    }()
    
    lazy var ordersView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var helpLabel: UIButton = {
        let label = UIButton()
        label.setTitle("Помощь", for: .normal)
        label.setTitleColor(.customTextBlack, for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: StaticSize.s20, weight: .medium)
        return label
    }()
    
    lazy var wppButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "wpp"), for: .normal)
        return view
    }()
    
    lazy var telegramButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "telegram"), for: .normal)
        return view
    }()
    
    lazy var helpView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cardView, addressView, ordersView, helpView])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.s10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUp()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        AppShared.sharedInstance.addressSubject.subscribe(onNext: {address in
            DispatchQueue.main.async {
                self.addressFullLabel.text = address.getAddress()
            }
        }).disposed(by: disposeBag)
    }
    
    func setUp(){
        addSubViews([phoneLabel, stack])

        phoneLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.s20)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        stack.snp.makeConstraints({
            $0.top.equalTo(phoneLabel.snp.bottom).offset(StaticSize.s30)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        cardView.addSubViews([cardLabel, cardImage, cardNumberLabel])
        cardLabel.snp.makeConstraints({
            $0.top.left.equalToSuperview()
        })
        
        cardImage.snp.makeConstraints({
            $0.top.equalTo(cardLabel.snp.bottom)
            $0.left.bottom.equalToSuperview()
        })
        
        cardNumberLabel.snp.makeConstraints({
            $0.centerY.equalTo(cardImage)
            $0.left.equalTo(cardImage.snp.right).offset(StaticSize.s5)
        })
        
        addressView.addSubViews([addressLabel, addressFullLabel])
        addressLabel.snp.makeConstraints({
            $0.top.left.equalToSuperview()
        })
        
        addressFullLabel.snp.makeConstraints({
            $0.top.equalTo(addressLabel.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
        
        ordersView.addSubViews([ordersLabel])
        ordersLabel.snp.makeConstraints({
            $0.top.left.bottom.equalToSuperview()
        })
        
        helpView.addSubViews([helpLabel, wppButton, telegramButton])
        helpLabel.snp.makeConstraints({
            $0.left.top.bottom.equalToSuperview()
        })
        
        wppButton.snp.makeConstraints({
            $0.left.equalTo(helpLabel.snp.right).offset(StaticSize.s20)
            $0.centerY.equalTo(helpLabel)
            $0.size.equalTo(StaticSize.s25)
        })
        
        telegramButton.snp.makeConstraints({
            $0.left.equalTo(wppButton.snp.right).offset(StaticSize.s15)
            $0.centerY.equalTo(helpLabel)
            $0.size.equalTo(StaticSize.s25)
        })
    }
}
