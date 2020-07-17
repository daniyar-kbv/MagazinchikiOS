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
        return label
    }()
    
    lazy var arrowImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrowDownBig")
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
        addSubViews([nameLabel, arrowImage])
        
        nameLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        })
        
        arrowImage.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        })
    }
    
    func setName(text: String){
        nameLabel.text = text
    }
}
