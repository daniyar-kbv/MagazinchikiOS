//
//  FirstScreenView.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class FirstScreenView: UIView {
    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s30, weight: .black)
        label.textColor = .customTextBlack
        label.text = "Название"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var blueDropImageView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "blueDrop")
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .customLightBlue
        return view
    }()
    
    lazy var bottomText: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isSelectable = false
        view.isScrollEnabled = false
        view.text = "Доставка продуктов и товаров для дома за 15 минут"
        view.font = .systemFont(ofSize: StaticSize.s22, weight: .regular)
        view.textColor = .customTextBlack
        return view
    }()
    
    lazy var nextButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Круто! Куда доставляете?", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        backgroundColor = .white
        
        addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop() + StaticSize.s100)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        addSubview(blueDropImageView)
        blueDropImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.s15)
            $0.size.equalTo(StaticSize.s200)
        })
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.s15)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        addSubview(bottomText)
        bottomText.snp.makeConstraints({
            $0.bottom.equalTo(nextButton.snp.top).offset(-StaticSize.s46)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
    }
}

