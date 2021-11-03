//
//  CustomCartBottomButton.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CustomCartBottomButton: UIButton {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s18, weight: .bold)
        label.textColor = .customTextBlack
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customLightGray
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, bottomLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .leading
        view.spacing = StaticSize.s5
        return view
    }()
    
    lazy var leftImagee: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "dots")
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
        addSubViews([stackView, leftImagee])
        
        stackView.snp.makeConstraints({
            $0.left.centerY.equalToSuperview()
        })
        
        leftImagee.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
            $0.size.equalTo(StaticSize.s30)
        })
    }
    
    func setName(text: String){
        nameLabel.text = text
    }
    
    func setBottom(text: String){
        bottomLabel.text = text
    }
}
