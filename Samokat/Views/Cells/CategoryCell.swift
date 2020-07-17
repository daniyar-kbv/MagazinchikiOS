//
//  CategoryCell.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CategoryCell: UITableViewCell {
    static var customReuseIdentifier = "CategoryCell"
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s18, weight: .bold)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubViews([title, bottomLine])
        
        title.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.top.bottom.equalToSuperview().inset(StaticSize.s15)
        })
        
        bottomLine.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(0.5)
        })
    }
    
    func setTitle(text: String){
        title.text = text
    }
}
