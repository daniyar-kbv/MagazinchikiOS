//
//  PhoneView.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class PhoneView: UIView, UITextFieldDelegate{
    var type: PhoneViewTypes? {
        didSet {
            guard let type = type else { return }
            
            switch type {
            case .phone:
                topText.text = "Укажите номер Вашего телефона, мы отправим туда СМС с кодом"
                field.placeholder = "+7 000 000 00 00"
                nextButton.setTitle("Далее", for: .normal)
            case .code:
                topText.text = "Введите код из СМС"
                field.placeholder = " - - - -"
            }
        }
    }
    
    lazy var phoneImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "phoneImg")
        return view
    }()
    
    lazy var topText: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isSelectable = false
        view.isScrollEnabled = false
        view.font = .systemFont(ofSize: StaticSize.s17, weight: .regular)
        view.textColor = .customLightGray
        return view
    }()
    
    lazy var field: UITextField = {
        let view = UITextField()
        view.textColor = .customTextBlack
        view.inputAccessoryView = inputButtonView
        view.font = .systemFont(ofSize: StaticSize.s34, weight: .bold)
        view.tintColor = .customLightGray
        view.keyboardType = .numberPad
        view.delegate = self
        view.adjustsFontSizeToFitWidth = true
        view.minimumFontSize = 10.0
        return view
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s17, weight: .light)
        label.textColor = .customStatusRed
        label.adjustsFontSizeToFitWidth = true
        label.isHidden = true
        return label
    }()
    
    lazy var inputButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nextButton: CustomButton = {
        let view = CustomButton()
        view.isActive = false
        view.isHidden = true
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
        addSubview(phoneImage)
        phoneImage.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.s60)
            $0.left.equalToSuperview().offset(StaticSize.s15)
            $0.height.equalTo(StaticSize.s118)
            $0.width.equalTo(StaticSize.s60)
        })
        
        addSubview(topText)
        topText.snp.makeConstraints({
            $0.top.equalTo(phoneImage.snp.bottom).offset(StaticSize.s15)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        addSubview(field)
        field.snp.makeConstraints({
            $0.top.equalTo(phoneImage.snp.bottom).offset(StaticSize.s100)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints({
            $0.top.equalTo(field.snp.bottom)
            $0.left.right.equalTo(field)
        })
        
        addSubview(inputButtonView)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !errorLabel.isHidden {
            errorLabel.isHidden = true
        }
        switch type {
        case .phone:
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            switch newString.count {
            case 0:
                break
            case 1:
                textField.text = "+7 \(newString)"
            case 3, 2:
                textField.text = "+7 "
            default:
                textField.text = newString.format()
            }
            nextButton.isActive = textField.text?.count == 16
            return false
        case .code:
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = newString.format(mask: "XXXX")
            nextButton.isActive = textField.text?.count == 4
            return false
        default:
            break
        }
        return true
    }
}
