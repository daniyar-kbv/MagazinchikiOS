//
//  PromocodeModalView.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class PromocodeModalView: UIView, UITextFieldDelegate{
    lazy var topText: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .systemFont(ofSize: StaticSize.s14, weight: .regular)
        view.textColor = .customTextBlack
        view.text = "Если у Вас есть промокод, скорее вводите его и получайте скидки"
        return view
    }()
    
    lazy var promocodeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.s14, weight: .regular)
        view.textColor = .customTextBlack
        view.text = "Промокод"
        return view
    }()
    
    lazy var field: UITextField = {
        let view = UITextField()
        view.textColor = .customTextBlack
        view.font = .sfProBold(size: 34)
        view.tintColor = .customLightGray
        view.keyboardType = .numberPad
        view.delegate = self
        view.adjustsFontSizeToFitWidth = true
        view.minimumFontSize = 10.0
        view.placeholder = "000000"
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Активировать", for: .normal)
        return view
    }()
    
    lazy var blankView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([topText, promocodeLabel, field, bottomButton, blankView])
        
        topText.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        promocodeLabel.snp.makeConstraints({
            $0.top.equalTo(topText.snp.bottom).offset(StaticSize.s25)
            $0.left.equalTo(topText)
        })
        
        field.snp.makeConstraints({
            $0.top.equalTo(promocodeLabel.snp.bottom).offset(StaticSize.s10)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        bottomButton.snp.makeConstraints({
            $0.top.equalTo(field.snp.bottom).offset(StaticSize.s40)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = newString.format(mask: "XXXXXX")
        return false
    }
}

