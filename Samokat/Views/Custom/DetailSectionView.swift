//
//  DetailSectionView.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DetailSectionView: UIView {
    lazy var topLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .bold)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var text: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        view.textColor = .customLightGray
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
        addSubViews([topLine, nameLabel, text])
        
        topLine.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.5)
        })
        
        nameLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.s20)
            $0.left.right.equalToSuperview()
        })
        
        text.snp.makeConstraints({
            $0.top.equalTo(nameLabel.snp.bottom).offset(StaticSize.s10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-StaticSize.s10)
        })
    }
    
    func setName(text: String){
        nameLabel.text = text
    }
    
    func setText(text: String){
        self.text.text = text
    }
}
