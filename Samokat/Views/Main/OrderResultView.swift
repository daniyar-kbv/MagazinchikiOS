//
//  OrderResultView.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class OrderResultView: UIView {
    var type: OrderRusultType? {
        didSet {
            guard let type = type else { return }
            switch type {
            case .success:
                topView.backgroundColor = .customGreen
                firstLabel.text = "Ваш заказ принят"
                secondLabel.text = "Курьер прибудет\nв течении 15 минут"
                firstButton.setTitle("В мои заказы", for: .normal)
                secondButton.isHidden = true
            case .failure:
                topView.backgroundColor = .customLightGray
                firstLabel.text = "Произошла ошибка"
                secondLabel.text = "Попробуйте еще раз"
                firstButton.setTitle("Попробовать еще раз", for: .normal)
            }
        }
    }
    
    lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s18, weight: .medium)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s1 * 32, weight: .bold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    lazy var firstButton: CustomButton = {
        let view = CustomButton()
        return view
    }()
    
    lazy var secondButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "buttonWhite"), for: .normal)
        view.setTitle("Отмена", for: .normal)
        view.setTitleColor(.customGreen, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: StaticSize.s16, weight: .bold)
        return view
    }()
    
    lazy var bottomStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [firstButton, secondButton])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.s10
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
    
    func setUp(){
        addSubViews([topView, bottomStack])
        
        topView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop())
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.s150)
        })
        
        topView.addSubViews([firstLabel, secondLabel])
        firstLabel.snp.makeConstraints({
            $0.top.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        secondLabel.snp.makeConstraints({
            $0.top.equalTo(firstLabel.snp.bottom).offset(StaticSize.s5)
            $0.left.right.equalTo(firstLabel)
        })
        
        bottomStack.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.s15)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        firstButton.snp.makeConstraints({
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        secondButton.snp.makeConstraints({
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
}

enum OrderRusultType {
    case success
    case failure
}
