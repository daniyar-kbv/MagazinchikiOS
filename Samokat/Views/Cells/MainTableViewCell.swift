//
//  MainTableViewCell.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    static let customReuseIdentifier = "MainTableViewCell"
    
    var titleValue: String? {
        didSet {
            guard let titleValue = titleValue else { return }
            title.text = titleValue
        }
    }
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .medium)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
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
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.top.bottom.equalToSuperview().inset(StaticSize.s8)
        })
    }
    
    func setTitle(text: String) {
        title.text = text
    }
}
