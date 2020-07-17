//
//  AuthTextField.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class AuthTextField: UIView, UITextFieldDelegate{
    
    var onReturn: (()->())?
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: StaticSize.s14, weight: .medium)
        view.textColor = .customTextBlack
        view.delegate = self
        return view
    }()
    
    lazy var eraseButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "eraseButton"), for: .normal)
        view.addTarget(self, action: #selector(erase), for: .touchUpInside)
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
        layer.cornerRadius = 5
        layer.borderColor = UIColor.customLightGray.cgColor
        layer.borderWidth = 1
        
        addSubview(textField)
        textField.snp.makeConstraints({
            print(self.constraints)
            $0.left.equalToSuperview().offset(StaticSize.s40/2.5)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-StaticSize.s40)
        })
        
        addSubview(eraseButton)
        eraseButton.snp.makeConstraints({
            $0.right.equalToSuperview().inset(StaticSize.s40/2.5)
            $0.size.equalTo(StaticSize.s40/2.5)
            $0.centerY.equalToSuperview()
        })
    }
    
    func setPlaceholder(text: String) {
        textField.placeholder = text
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            if let onReturn = onReturn{
                onReturn()
            }
            return false
        }
        return true
    }
    
    @objc func erase(){
        textField.text = ""
    }
}
