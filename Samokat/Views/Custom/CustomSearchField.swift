//
//  CustomSearchField.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class CustomSearchField: UIView, UITextFieldDelegate {
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "figureUpDown")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .customLightBlue
        return view
    }()
    
    lazy var loupeImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "loupe")
        return view
    }()
    
    lazy var field: UITextField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: StaticSize.s13, weight: .regular)
        view.delegate = self
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
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        addSubview(loupeImage)
        loupeImage.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.s20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.s16)
        })
        
        addSubview(field)
        field.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalTo(loupeImage.snp.right).offset(StaticSize.s15)
            $0.right.equalToSuperview().offset(-StaticSize.s20)
        })
    }
    
    func setPlaceholder(text: String){
        field.placeholder = text
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}
