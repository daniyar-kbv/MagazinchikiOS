//
//  CardView.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BankCardView: UIView {
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
    
    lazy var deleteButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "trashBin"), for: .normal)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s30, weight: .regular)
        label.textColor = .customTextBlack
        label.text = "Добавление карты"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var cardBack: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cardRect")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .customLightBlue
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var cardLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        view.textColor = .customTextBlack
        view.text = "НОМЕР КАРТЫ"
        return view
    }()
    
    lazy var cardField: CardTextField = {
        let view = CardTextField()
        view.placeholder = "0000 0000 0000 0000"
        view.inputAccessoryView = inputButtonView
        return view
    }()
    
    lazy var expireLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        view.textColor = .customTextBlack
        view.text = "СРОК ДЕЙСТВИЯ"
        return view
    }()
    
    lazy var expireField: CardTextField = {
        let view = CardTextField()
        view.placeholder = "MM/YY"
        view.inputAccessoryView = inputButtonView
        return view
    }()
    
    lazy var cvvLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        view.textColor = .customTextBlack
        view.text = "CVV"
        return view
    }()
    
    lazy var cvvField: CardTextField = {
        let view = CardTextField()
        view.placeholder = "000"
        view.inputAccessoryView = inputButtonView
        return view
    }()
    
    lazy var inputButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nextButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Добавить", for: .normal)
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
        addSubViews([topBrush, backButton, deleteButton, titleLabel, cardBack, inputButtonView])
        
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
        
        deleteButton.snp.makeConstraints({
            $0.top.right.equalToSuperview().inset(StaticSize.s15)
            $0.size.equalTo(StaticSize.s30)
        })
        
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(backButton.snp.bottom).offset(StaticSize.s15)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        cardBack.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.s10)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo((ScreenSize.SCREEN_WIDTH - StaticSize.s30) * 0.6)
        })
        
        cardBack.addSubViews([cardLabel, cardField, expireLabel, expireField, cvvLabel, cvvField])
        
        expireField.snp.makeConstraints({
            $0.bottom.left.equalToSuperview().inset(StaticSize.s15)
            $0.right.equalTo(self.snp.centerX).offset(-StaticSize.s3)
            $0.height.equalTo(StaticSize.s36)
        })
        
        expireLabel.snp.makeConstraints({
            $0.bottom.equalTo(expireField.snp.top).offset(-StaticSize.s5)
            $0.left.equalToSuperview().offset(StaticSize.s15)
        })
        
        cvvField.snp.makeConstraints({
            $0.left.equalTo(self.snp.centerX).offset(StaticSize.s3)
            $0.bottom.size.equalTo(expireField)
        })
        
        cvvLabel.snp.makeConstraints({
            $0.bottom.equalTo(expireLabel)
            $0.left.equalTo(cvvField)
        })
        
        cardField.snp.makeConstraints({
            $0.bottom.equalTo(expireLabel.snp.top).offset(-StaticSize.s5)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(StaticSize.s36)
        })
        
        cardLabel.snp.makeConstraints({
            $0.bottom.equalTo(cardField.snp.top).offset(-StaticSize.s5)
            $0.left.equalTo(cardField)
        })
        
        inputButtonView.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.s30)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.buttonHeight + StaticSize.s30)
        })
        
        inputButtonView.addSubview(nextButton)
        nextButton.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(StaticSize.s15)
        })
    }
}
