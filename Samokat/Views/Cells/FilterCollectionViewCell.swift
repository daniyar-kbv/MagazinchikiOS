//
//  FilterCollectionViewCell.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class FilterCollectionViewCell: UICollectionViewCell {
    static var customReuseIdentifier = "FilterCollectionViewCell"
    var isActive: Bool = false {
        didSet {
            backImage.image = UIImage(named: isActive ? "filterFigureGreen" : "filterFigure")
            title.textColor = isActive ? .white : .customGreen
        }
    }
    
    lazy var backImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "filterFigure")
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .medium)
        label.textColor = .customGreen
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubViews([backImage, title])
        
        backImage.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        title.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(StaticSize.s5)
            $0.left.right.equalToSuperview().inset(StaticSize.s10)
        })
    }
    
    func setTitle(text: String){
        title.text = text
        title.sizeToFit()
    }
}
