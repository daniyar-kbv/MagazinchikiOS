//
//  File.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TopFilterView: UIButton {
    var isUp = true
    
    lazy var backImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "filterFigureGreen")
        return view
    }()
    
    lazy var arrowImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrowDown")
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.s12, weight: .medium)
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
        addSubViews([backImage])
        
        backImage.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        backImage.addSubViews([arrowImage, title])
        
        arrowImage.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.s10)
            $0.width.equalTo(StaticSize.s10)
            $0.height.equalTo(StaticSize.s5)
            $0.top.bottom.equalToSuperview().inset(StaticSize.s13)
        })
        
        title.snp.makeConstraints({
            $0.left.equalTo(arrowImage.snp.right).offset(StaticSize.s5)
            $0.centerY.equalTo(arrowImage)
            $0.right.equalToSuperview().offset(-StaticSize.s10)
        })
    }
    
    func setTitle(text: String) {
        title.text = text
    }
}
