//
//  OrderDetailCell.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class OrderDetailCell: UITableViewCell {
    static var customReuseIdentifier = "OrderDetailCell"
    
   lazy var photo: UIImageView = {
        let view = UIImageView()
        let mask = UIImageView(image: UIImage(named: "squareFigureSmall"))
        mask.frame.size = CGSize(width: StaticSize.s50, height: StaticSize.s50)
        view.mask = mask
        view.kf.setImage(with: URL(string: "https://dastarkhan24.kz/upload/iblock/e55/e55878eb073a1e7d7b5f41146fa5c882.jpg"))
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customTextBlack
        label.text = "Молоко Айналайын пастеризованное, 3,2%, 1000 г"
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s15, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "1 198 ₸"
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubViews([photo, priceLabel, titleLabel])
        
        photo.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
            $0.size.equalTo(StaticSize.s50)
        })
        
        priceLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-StaticSize.s15)
        })
        
        titleLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalTo(photo.snp.right).offset(StaticSize.s15)
            $0.right.equalTo(priceLabel.snp.left).offset(-StaticSize.s15)
        })
    }
}
