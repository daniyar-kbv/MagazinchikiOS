//
//  MainPageViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class MainPageView: UIView {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.delaysContentTouches = false
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: StaticSize.s100, right: 0)
        view.register(MainTableViewHeader.self, forCellReuseIdentifier: MainTableViewHeader.customReuseIdentifier)
        view.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.customReuseIdentifier)
        return view
    }()
    
    lazy var topContainer: AddressView = {
        let view = AddressView()
        return view
    }()
    
    lazy var searchField: CustomSearchField = {
        let view = CustomSearchField()
        view.setPlaceholder(text: "Это поиск по магазину")
        return view
    }()
    
    lazy var cartView: CustomCartView = {
        let view = CustomCartView()
        return view
    }()
    
    lazy var smallFigureView: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "figureUpSmall"), for: .normal)
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
        addSubview(topContainer)
        topContainer.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop())
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        addSubview(searchField)
        searchField.snp.makeConstraints({
            $0.top.equalTo(topContainer.snp.bottom).offset(StaticSize.s5)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(StaticSize.s40)
        })
        
        addSubview(tableView)
        tableView.snp.makeConstraints({
            $0.top.equalTo(searchField.snp.bottom).offset(StaticSize.s20)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.bottom.equalToSuperview()
        })
        
        addSubview(cartView)
        if AppShared.sharedInstance.cart.items?.count ?? 0 > 0{
            cartView.snp.makeConstraints({
                $0.left.right.equalToSuperview().inset(StaticSize.s15)
                $0.height.equalTo(StaticSize.buttonHeight)
                $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.s15)
            })
        } else {
            cartView.snp.makeConstraints({
                $0.left.right.equalToSuperview().inset(StaticSize.s15)
                $0.height.equalTo(StaticSize.buttonHeight)
                $0.bottom.equalToSuperview().offset(StaticSize.buttonHeight)
            })
        }
        
        addSubview(smallFigureView)
        smallFigureView.snp.makeConstraints({
            $0.right.equalTo(cartView)
            $0.bottom.equalTo(cartView.snp.top).offset(-StaticSize.s15)
            $0.size.equalTo(StaticSize.s44)
        })
    }
}
