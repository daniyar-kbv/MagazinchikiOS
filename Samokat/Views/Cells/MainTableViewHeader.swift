//
//  MainTableViewHeader.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MainTableViewHeader: UITableViewCell {
    static let customReuseIdentifier = "MainTableViewHeader"
    
    lazy var title: CustomLabelWithoutPadding = {
        let label = CustomLabelWithoutPadding()
        label.font = .systemFont(ofSize: StaticSize.s20, weight: .bold)
        label.textColor = .customTextBlack
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        selectionStyle = .none
        
        addSubview(title)
        title.snp.makeConstraints({
            $0.left.equalToSuperview().inset(StaticSize.s15)
            $0.right.equalToSuperview().offset(-((ScreenSize.SCREEN_WIDTH - StaticSize.s30) * 0.25))
            $0.top.equalToSuperview().offset(StaticSize.s20)
            $0.bottom.equalToSuperview()
        })
    }
    
    func setTitle(text: String) {
        title.text = text
    }
}
