//
//  ProductsCollectionViewCell.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class ProductsCollectionViewCell: UICollectionViewCell {
    static var customReuseIdentifier = "ProductsCollectionViewCell"
    var count: Int = 0
    var product: Product? {
        didSet{
            guard let product = product else { return }
            photo.backgroundColor = UIColor(hex: product.bgColor ?? "#cccccc")
            if let count = product.price?.count {
                discountView.isHidden = false
                discountLabel.text = "-\(count)%"
            }
            if let oldPrice = product.price?.oldPrice{
                oldPriceLabel.isHidden = false
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
                oldPriceLabel.attributedText = attributeString
            }
            newPriceLabel.text = "\(product.price?.currentPrice ?? "")₸"
            descriptionLabel.text = product.details?.title ?? ""
            toCartButton.product = product
            photoInner.kf.setImage(with: URL(string: product.icon ?? ""))
        }
    }
    
    lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var photo: UIView = {
        let view = UIView()
        let mask = UIImageView(image: UIImage(named: "squareFigure"))
        mask.frame.size = CGSize(width: (ScreenSize.SCREEN_WIDTH - StaticSize.s40) / 2, height: (ScreenSize.SCREEN_WIDTH - StaticSize.s40) / 2)
        view.mask = mask
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var photoInner: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var discountView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "figureCorner")
        view.isHidden = true
        return view
    }()
    
    lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s15, weight: .regular)
        label.textColor = .customLightGray
        label.isHidden = true
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
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.s5
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: StaticSize.s12, weight: .medium)
        view.textColor = .customTextBlack
        view.numberOfLines = 2
        view.lineBreakMode = .byTruncatingTail
        view.text = "Молоко Айналайын пастеризованное пакетированое"
        return view
    }()
    
    lazy var toCartButton: ToCartButton = {
        let view = ToCartButton()
        view.product = product
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        toCartButton.count = 0
    }
    
    func setUp(){
        addSubViews([container])
        
        container.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(StaticSize.s10)
        })
        
        container.addSubViews([photo, priceStack, descriptionLabel, toCartButton])
        
        photo.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.width.equalTo((ScreenSize.SCREEN_WIDTH - StaticSize.s40) / 2)
            $0.height.equalTo((ScreenSize.SCREEN_WIDTH - StaticSize.s40) / 2)
        })
        
        photo.addSubViews([photoInner, discountView])
        photoInner.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().multipliedBy(0.85)
        })
        
        discountView.snp.makeConstraints({
            $0.left.bottom.equalToSuperview()
        })
        
        discountView.addSubViews([discountLabel])
        discountLabel.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(StaticSize.s5)
        })
        
        priceStack.snp.makeConstraints({
            $0.top.equalTo(photo.snp.bottom).offset(StaticSize.s8)
            $0.left.equalToSuperview()
        })
        
        descriptionLabel.snp.makeConstraints({
            $0.top.equalTo(priceStack.snp.bottom).offset(StaticSize.s3)
            $0.left.right.equalToSuperview()
        })
        
        toCartButton.snp.makeConstraints({
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(StaticSize.s15)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(StaticSize.s34)
        })
    }
}
