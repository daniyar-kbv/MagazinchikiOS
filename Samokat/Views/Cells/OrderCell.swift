//
//  OrderCell.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class OrderCell: UITableViewCell {
    static var customReuseIdentifier = "OrderCell"
    
    lazy var backView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "orderRect")
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = StaticSize.s3
        view.layer.shadowOpacity = 0.01
        view.layer.shadowOffset = .zero
        return view
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .bold)
        label.textColor = .customLightGray
        label.text = "Заказ №28149495"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .bold)
        label.textColor = .customStatusRed
        label.text = "Отменен"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customTextBlack
        label.text = "25 июня, 12:05"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var addressLabel: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        view.textColor = .customLightGray
        view.text = "Орбита 1 микрорайон, дом 38"
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .medium)
        label.textColor = .customTextBlack
        label.text = "3 наименования на 3 005 ₸ "
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var reButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "orderRectSmall"), for: .normal)
        view.setImage(UIImage(named: "cycle"), for: .normal)
        return view
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
        addSubViews([backView])
        
        backView.snp.makeConstraints({
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(-StaticSize.s5)
        })
        
        backView.addSubViews([numberLabel, statusLabel, dateLabel, addressLabel, title, reButton])
        
        numberLabel.snp.makeConstraints({
            $0.left.top.equalToSuperview().inset(StaticSize.s15 + 15)
        })
        
        statusLabel.snp.makeConstraints({
            $0.top.right.equalToSuperview().inset(StaticSize.s15 + 15)
        })
        
        dateLabel.snp.makeConstraints({
            $0.top.equalTo(numberLabel.snp.bottom).offset(StaticSize.s15)
            $0.left.equalToSuperview().offset(StaticSize.s15 + 15)
        })
        
        addressLabel.snp.makeConstraints({
            $0.top.equalTo(dateLabel.snp.bottom).offset(StaticSize.s5)
            $0.left.equalToSuperview().offset(StaticSize.s15 + 15)
        })
        
        title.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-StaticSize.s20 - 15)
            $0.left.equalToSuperview().offset(StaticSize.s15 + 15)
        })
        
        reButton.snp.makeConstraints({
            $0.bottom.right.equalToSuperview().inset(15)
        })
    }
}
