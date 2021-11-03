//
//  NoInternetView.swift
//  Samokat
//
//  Created by Daniyar on 7/15/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class NoInternetView: UIView{

    
    lazy var image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "internet")
        return view
    }()
    
    lazy var text: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: StaticSize.s16, weight: .medium)
        view.textColor = .customLightGray
        view.text = "Нет связи\nПроверьте интернет соединение"
        return view
    }()
    
    lazy var button: CustomButton = {
        let view = CustomButton()
        view.setTitle("Повторить", for: .normal)
        return view
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [image, text, button])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        view.spacing = StaticSize.s30
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubViews([stack])
        
        stack.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        image.snp.makeConstraints({
            $0.width.equalTo(StaticSize.s121)
            $0.height.equalTo(StaticSize.s90)
        })
        
        button.snp.makeConstraints({
            $0.height.equalTo(StaticSize.buttonHeight)
            $0.width.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
