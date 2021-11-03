//
//  CartTableViewCell.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CartTableViewCell: UITableViewCell {
    static var customReuseIdentifier = "CartTableViewCell"
    var product: Product? {
        didSet{
            guard let product = product else { return }
            photo.backgroundColor = UIColor(hex: product.bgColor ?? "#cccccc")
            if let oldPrice = Int(product.price?.oldPrice ?? "")?.formattedWithSeparator{
                oldPriceLabel.isHidden = false
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
                oldPriceLabel.attributedText = attributeString
            }
            newPriceLabel.text = "\(Int(product.price?.currentPrice ?? "")?.formattedWithSeparator ?? "")₸"
            nameLabel.text = product.details?.title ?? ""
            cartButton.product = product
        }
    }
    
    lazy var photo: UIView = {
        let view = UIView()
        let mask = UIImageView(image: UIImage(named: "squareFigureSmall"))
        mask.frame.size = CGSize(width: StaticSize.s70, height: StaticSize.s70)
        view.mask = mask
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var photoInner: UIImageView = {
        let view = UIImageView()
        view.kf.setImage(with: URL(string: "https://lh3.googleusercontent.com/proxy/aeceLnP_Na8z39BPgoDGkztDoSJOccZPvenyO9K72kTPV9_qd1kZiWjBdgR0TcNoNkxY-yU_EFKdereSeXy_toUk0NTwoR3esoWv8Lk7U9RzvaznW7YyaYq9agzSSDHL5q_BbbjLX10CJyPTqJDUG5GQJQ"))
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customTextBlack
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var cartButton: ToCartButton = {
        let view = ToCartButton(count: 1, withCart: false)
        return view
    }()
    
    lazy var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s15, weight: .regular)
        label.textColor = .customLightGray
        return label
    }()
    
    lazy var newPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s15, weight: .bold)
        label.textColor = .customTextBlack
        return label
    }()
    
    lazy var priceStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [newPriceLabel, oldPriceLabel])
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .trailing
        view.spacing = StaticSize.s5
        return view
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
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
    
    @objc func removeItem(){
        guard let product = product else { return }
        AppShared.sharedInstance.cart.change(product: product, type: .remove)
    }
    
    func setUp() {
        addSubViews([photo, cartButton, nameLabel, priceStack, bottomLine])
        
        photo.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
            $0.size.equalTo(StaticSize.s70)
        })
        
        photo.addSubViews([photoInner])
        photoInner.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().multipliedBy(0.85)
        })
        
        cartButton.snp.makeConstraints({
            $0.top.equalTo(photo)
            $0.right.equalToSuperview()
            $0.width.equalTo(StaticSize.s115)
            $0.height.equalTo(StaticSize.s36)
        })
        
        nameLabel.snp.makeConstraints({
            $0.top.equalTo(photo)
            $0.left.equalTo(photo.snp.right).offset(StaticSize.s8)
            $0.right.equalTo(cartButton.snp.left).offset(-StaticSize.s8)
        })
        
        priceStack.snp.makeConstraints({
            $0.bottom.equalTo(photo)
            $0.left.equalTo(nameLabel)
        })
        
        bottomLine.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.5)
        })
    }
}
