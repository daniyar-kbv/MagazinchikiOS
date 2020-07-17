//
//  ProductDetailView.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ProductDetailView: UIView {
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
            componentsView.setText(text: product.description ?? "")
            makeView.setText(text: product.details?.unit ?? "")
            if let properties = product.properties{
                nutrientsStack.setValues(cals: properties.kcal ?? "", prots: properties.protein ?? "", fats: properties.fat ?? "", carbs: properties.carbohydrates ?? "")
            }
        }
    }
    
    lazy var topBrush: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .white
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: StaticSize.s100, trailing: 0)
        view.axis = .vertical
        view.spacing = StaticSize.s5
        return view
    }()
    
    lazy var photo: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.kf.setImage(with: URL(string: "https://dastarkhan24.kz/upload/iblock/e55/e55878eb073a1e7d7b5f41146fa5c882.jpg"))
        return view
    }()
    
    lazy var nameLabel: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .systemFont(ofSize: StaticSize.s22, weight: .bold)
//        view.attributedText = "Йогурт, 130 гр".changeSubstringFont(lastElement: ",", font: .systemFont(ofSize: StaticSize.s1 * 18, weight: .regular))
        view.textColor = .customTextBlack
        return view
    }()
    
    lazy var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s20, weight: .regular)
        label.textColor = .customLightGray
        return label
    }()
    
    lazy var newPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s20, weight: .bold)
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
    
    lazy var priceView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nutrientsStack: NutrientsView = {
        let view = NutrientsView()
        return view
    }()
    
    lazy var componentsView: DetailSectionView = {
        let view = DetailSectionView()
        view.setName(text: "Состав")
        return view
    }()
    
    lazy var makeView: DetailSectionView = {
        let view = DetailSectionView()
        view.setName(text: "Производитель")
        return view
    }()
    
    lazy var toCartButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Добавить в корзину", for: .normal)
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
    
    func setUp() {
        addSubViews([topBrush, mainScrollView, toCartButton])
        
        topBrush.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(5)
            $0.width.equalTo(45)
            $0.centerX.equalToSuperview()
        })
        
        toCartButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.s20)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        mainScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true;
        mainScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: StaticSize.s40).isActive = true;
        mainScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true;
        mainScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true;

        mainScrollView.addSubview(mainStackView)

        mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true;
        mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true;
        mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor).isActive = true;
        mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true;
        mainStackView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor).isActive = true;
        
        mainStackView.addArrangedSubViews([photo, nameLabel, priceView, nutrientsStack, componentsView, makeView])
        
        photo.snp.makeConstraints({
            $0.size.equalTo(ScreenSize.SCREEN_WIDTH)
        })
        
        nameLabel.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        priceView.addSubViews([priceStack])
        priceStack.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-StaticSize.s15)
        })
        
        nutrientsStack.snp.makeConstraints({
            $0.height.equalTo(StaticSize.s80)
        })
        
    }
}
