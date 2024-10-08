//
//  LoactionView.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import YandexMapKit

class LocationView: UIView {
    lazy var mapView: YMKMapView = {
        let view = YMKMapView()
        return view
    }()
    
    lazy var darkBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    lazy var backButtonImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "backButton")
        return view
    }()
    
    lazy var bottomContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.1
        view.backgroundColor = .white
        return view
    }()
    
    lazy var topSmallContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s16, weight: .regular)
        label.textColor = .customLightGray
        label.text = "Адрес"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var topBrush: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    lazy var locationButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "locationButton"), for: .normal)
        return view
    }()
    
    lazy var addressField: AuthTextField = {
        let view = AuthTextField()
        view.setPlaceholder(text: "Адрес дома")
        return view
    }()
    
    lazy var houseField: AuthTextField = {
        let view = AuthTextField()
        view.setPlaceholder(text: "Подъезд, квартира")
        return view
    }()
    
    lazy var fieldsStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [addressField, houseField])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.s20
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.layoutMargins = .zero
        view.separatorInset = .zero
        view.separatorStyle = .none
        return view
    }()
    
    lazy var errorLabel: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .systemFont(ofSize: StaticSize.s16, weight: .regular)
        view.textColor = .customLightGray
        view.isHidden = true
        return view
    }()
    
    lazy var nextButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Везите сюда", for: .normal)
        view.isActive = false
        return view
    }()
    
    lazy var pinView: UIImageView = {
        let width = StaticSize.s50
        let height = width / 0.832
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.image = UIImage(named: "pin")
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
        addSubview(mapView)
        mapView.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(0)
        })
        
        addSubview(backButton)
        backButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop() + StaticSize.s10)
            $0.left.equalToSuperview().offset(StaticSize.s10)
            $0.size.equalTo(StaticSize.s40)
        })
        
        backButton.addSubViews([backButtonImage])
        backButtonImage.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(StaticSize.s10)
            $0.height.equalTo(StaticSize.s18)
        })
        
        addSubview(bottomContainer)
        bottomContainer.snp.makeConstraints({
            $0.bottom.left.right.equalToSuperview()
//            $0.height.equalTo(StaticSize.s260)
        })
        
        bottomContainer.addSubview(topSmallContainer)
        topSmallContainer.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.s60)
        })
        
        topSmallContainer.addSubview(addressLabel)
        addressLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.s15)
        })
        
        topSmallContainer.addSubview(topBrush)
        topBrush.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(5)
            $0.width.equalTo(45)
            $0.centerX.equalToSuperview()
        })
        
        topSmallContainer.addSubview(locationButton)
        locationButton.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-StaticSize.s15)
            $0.size.equalTo(StaticSize.s40)
        })
        
        bottomContainer.addSubview(fieldsStack)
        fieldsStack.snp.makeConstraints({
            $0.top.equalTo(topSmallContainer.snp.bottom).offset(StaticSize.s20)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(StaticSize.s100)
        })

        addressField.snp.makeConstraints({
            $0.height.equalTo(StaticSize.s40)
        })

        houseField.snp.makeConstraints({
            $0.height.equalTo(StaticSize.s40)
        })
        
        bottomContainer.addSubview(tableView)
        tableView.snp.makeConstraints({
            $0.left.right.equalTo(fieldsStack)
            $0.top.equalTo(fieldsStack.snp.bottom).offset(StaticSize.s10)
        })
        
        bottomContainer.addSubview(errorLabel)
        errorLabel.snp.makeConstraints({
            $0.top.equalTo(fieldsStack.snp.bottom).offset(StaticSize.s5)
            $0.left.right.equalTo(fieldsStack)
        })
        
        bottomContainer.addSubview(nextButton)
        nextButton.snp.makeConstraints({
            $0.top.equalTo(tableView.snp.bottom).offset(StaticSize.s30).priority(.low)
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.s15)).priority(.high)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
    
    func showError(show: Bool, text: String = "") {
        errorLabel.text = text
        errorLabel.isHidden = !show
        nextButton.isHidden = show
    }
}
