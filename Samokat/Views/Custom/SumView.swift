//
//  SumView.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SumView: UIStackView {
    lazy var overallView: SumSubview = {
        let view = SumSubview()
        view.valueLabel.font = .systemFont(ofSize: StaticSize.s1 * 24, weight: .bold)
        return view
    }()
    
    lazy var discountView: SumSubview = {
        let view = SumSubview()
        return view
    }()
    
    lazy var promocodeView: SumSubview = {
        let view = SumSubview()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        distribution = .equalCentering
        alignment = .center
        addArrangedSubViews([overallView, discountView, promocodeView])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNames(_ first: String, _ second: String, _ third: String){
        overallView.setName(text: first)
        discountView.setName(text: second)
        promocodeView.setName(text: third)
    }
    
    func setValues(_ first: String, _ second: String, _ third: String){
        overallView.setValue(text: first)
        discountView.setValue(text: second)
        promocodeView.setValue(text: third)
    }
}

class SumSubview: UIStackView {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customLightGray
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s20, weight: .regular)
        label.textColor = .customTextBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addArrangedSubViews([nameLabel, valueLabel])
        axis = .vertical
        distribution = .equalCentering
        alignment = .leading
        spacing = StaticSize.s10
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setName(text: String) {
        nameLabel.text = text
    }
    
    func setValue(text: String) {
        valueLabel.text = text
    }
}
