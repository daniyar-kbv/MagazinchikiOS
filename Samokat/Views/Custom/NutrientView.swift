//
//  NutrientView.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class NutrientInnerView: UIStackView {
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .bold)
        label.textColor = .customTextBlack
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s14, weight: .regular)
        label.textColor = .customLightGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    required init(type: NutrientTypes) {
        super.init(frame: .zero)
        
        nameLabel.text = type.rawValue
        axis = .vertical
        distribution = .equalCentering
        alignment = .center
        spacing = StaticSize.s10
        addArrangedSubViews([numberLabel, nameLabel])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNumber(number: String){
        numberLabel.text = number
    }
}

class NutrientsView: UIStackView {
    lazy var calView: NutrientInnerView = {
        let view = NutrientInnerView(type: .calories)
        return view
    }()
    
    lazy var protView: NutrientInnerView = {
        let view = NutrientInnerView(type: .proteins)
        return view
    }()
    
    lazy var fatView: NutrientInnerView = {
        let view = NutrientInnerView(type: .fat)
        return view
    }()
    
    lazy var carbView: NutrientInnerView = {
        let view = NutrientInnerView(type: .carbohydrates)
        return view
    }()
    
    lazy var topLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        distribution = .equalCentering
        alignment = .center
        addArrangedSubViews([calView, protView, fatView, carbView])
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([topLine])
        
        topLine.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(-StaticSize.s15)
            $0.height.equalTo(0.5)
        })
    }
    
    func setValues(cals: String, prots: String, fats: String, carbs: String) {
        calView.setNumber(number: cals)
        protView.setNumber(number: prots)
        fatView.setNumber(number: fats)
        carbView.setNumber(number: carbs)
    }
}

enum NutrientTypes: String {
    case calories = "ккал"
    case proteins = "белки"
    case carbohydrates = "углеводы"
    case fat = "жиры"
}
