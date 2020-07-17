//
//  PaymentTypeCell.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PaymentTypeCell: CategoryCell {
    lazy var radioButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "emptyRadio")
        return view
    }()
    
    lazy var cardImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cardSmall")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .customTextBlack
        return view
    }()
    
    lazy var cardNumber: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .regular)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        label.text = "•••• 9858"
        return label
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp_()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp_(){
        addSubViews([radioButton, cardView])
        
        radioButton.snp.makeConstraints({
            $0.centerY.equalTo(title)
            $0.right.equalToSuperview().offset(-StaticSize.s15)
            $0.size.equalTo(StaticSize.s22)
        })
        
        cardView.snp.makeConstraints({
            $0.left.equalTo(self.snp.centerX).offset(StaticSize.s10)
            $0.top.bottom.equalToSuperview()
            $0.right.equalTo(radioButton.snp.left).offset(-StaticSize.s20)
        })

        cardView.addSubViews([cardImage, cardNumber])
        cardImage.snp.makeConstraints({
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(StaticSize.s28)
            $0.height.equalTo(StaticSize.s18)
        })

        cardNumber.snp.makeConstraints({
            $0.left.equalTo(cardImage.snp.right).offset(StaticSize.s5)
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        })
    }
    
    func select(_ select: Bool){
        radioButton.image = select ? UIImage(named: "selectedRadio") : UIImage(named: "emptyRadio")
    }
}
