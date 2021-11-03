//
//  OrdersView.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class OrdersView: UIView {
    
    lazy var topBrush: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "backButtonSmall"), for: .normal)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s30, weight: .bold)
        label.textColor = .customTextBlack
        label.text = "Мои заказы"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.rowHeight = StaticSize.s160
        view.register(OrderCell.self, forCellReuseIdentifier: OrderCell.customReuseIdentifier)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Global.safeAreaBottom(), right: 0)
        view.delaysContentTouches = false
        view.showsVerticalScrollIndicator = false
        view.allowsSelection = false
        view.isUserInteractionEnabled = true
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
        addSubViews([topBrush, backButton, titleLabel, tableView])
        
        topBrush.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(5)
            $0.width.equalTo(45)
            $0.centerX.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({
            $0.left.top.equalToSuperview().offset(StaticSize.s15)
            $0.size.equalTo(StaticSize.s30)
        })
        
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(backButton.snp.bottom).offset(StaticSize.s15)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.s20)
            $0.left.right.bottom.equalToSuperview()
        })
    }
}
