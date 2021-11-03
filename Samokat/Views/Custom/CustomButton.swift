//
//  CustomButton.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CustomButton: UIButton {
    var backgroundImage: UIImage = UIImage(named: "buttonDown")!
    var isActive: Bool = true {
        didSet {
            setBackgroundImage(backgroundImage.withTintColor(UIColor.customGreen.withAlphaComponent(isActive ? 1 : 0.5)), for: .normal)
            isUserInteractionEnabled = isActive
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackgroundImage(backgroundImage, for: .normal)
        titleLabel?.font = .systemFont(ofSize: StaticSize.s16, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomButtonTwoText: CustomButton {
    lazy var leftTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.s16, weight: .bold)
        view.textColor = .white
        return view
    }()
    
    lazy var rightTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.s16, weight: .bold)
        view.textColor = .white
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
        addSubViews([leftTitle, rightTitle])
        
        leftTitle.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.s20)
            $0.centerY.equalToSuperview()
        })
        
        rightTitle.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.s20)
            $0.centerY.equalToSuperview()
        })
    }
    
    func setLeftTitle(text: String) {
        leftTitle.text = text
    }
    
    func setRightTitle(text: String) {
        rightTitle.text = text
    }
}
