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
            if let oldPrice = product.price?.oldPrice{
                oldPriceLabel.isHidden = false
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
                oldPriceLabel.attributedText = attributeString
            }
            newPriceLabel.text = "\(product.price?.currentPrice ?? "")₸"
            nameLabel.text = product.details?.title ?? ""
            cartButton.product = product
        }
    }
    
    lazy var photo: UIImageView = {
        let view = UIImageView()
        let mask = UIImageView(image: UIImage(named: "squareFigureSmall"))
        mask.frame.size = CGSize(width: StaticSize.s70, height: StaticSize.s70)
        view.mask = mask
        view.kf.setImage(with: URL(string: "https://dastarkhan24.kz/upload/iblock/e55/e55878eb073a1e7d7b5f41146fa5c882.jpg"))
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .customTextBlack
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var cartButton: ToCartButton = {
        let view = ToCartButton(count: 1, withCart: false)
        return view
    }()
    
    lazy var closeButon: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "cross"), for: .normal)
        view.addTarget(self, action: #selector(removeItem), for: .touchUpInside)
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
        let view = UIStackView(arrangedSubviews: [oldPriceLabel, newPriceLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .trailing
        view.spacing = 0
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
        addSubViews([photo, nameLabel, cartButton, closeButon, priceStack, bottomLine])
        
        photo.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
            $0.size.equalTo(StaticSize.s70)
        })
        
        closeButon.snp.makeConstraints({
            $0.top.equalTo(photo)
            $0.right.equalToSuperview()
            $0.size.equalTo(StaticSize.s20)
        })
        
        nameLabel.snp.makeConstraints({
            $0.top.equalTo(photo)
            $0.left.equalTo(photo.snp.right).offset(StaticSize.s8)
            $0.right.equalTo(closeButon.snp.left).offset(-StaticSize.s8)
        })
        
        cartButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-StaticSize.s15)
            $0.left.equalTo(nameLabel)
            $0.width.equalTo((ScreenSize.SCREEN_WIDTH - StaticSize.s40) / 2)
            $0.height.equalTo(StaticSize.s36)
        })
        
        priceStack.snp.makeConstraints({
            $0.right.equalToSuperview()
            $0.centerY.equalTo(cartButton)
        })
        
        bottomLine.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.5)
        })
    }
}
