//
//  CardTextField.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class CardTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: StaticSize.s10, bottom: 0, right: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = StaticSize.s3
        layer.borderColor = UIColor.customGray.cgColor
        layer.borderWidth = StaticSize.s1
        keyboardType = .numberPad
        backgroundColor = .white
        font = .systemFont(ofSize: StaticSize.s13, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
