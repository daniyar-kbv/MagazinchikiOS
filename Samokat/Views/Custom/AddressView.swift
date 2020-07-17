//
//  AddressView.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AddressView: UIView {
    var withAddress: Bool = false {
        didSet {
            addressLabel.isHidden = !withAddress
            addressView.snp.updateConstraints({
                $0.top.equalToSuperview().offset(StaticSize.s10)
            })
        }
    }
    
    lazy var editButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "pencil"), for: .normal)
        return view
    }()
    
    lazy var profileButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "person"), for: .normal)
        return view
    }()
    
    lazy var addressLabel: CustomLabel = {
        let view = CustomLabel()
        view.font = .systemFont(ofSize: StaticSize.s10, weight: .regular)
        view.textColor = .customTextBlack
        view.text = "Адрес:"
        view.isHidden = true
        return view
    }()
    
    lazy var addressView: CustomLabel = {
        let view = CustomLabel()
        view.font = .systemFont(ofSize: StaticSize.s12, weight: .medium)
        view.textColor = .customTextBlack
        view.text = "Орбита 1 микрорайон, дом 38, кв 94"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        profileButton.addTarget(self, action: #selector(openProfile(sender:)), for: .touchUpInside)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubview(editButton)
        editButton.snp.makeConstraints({
            $0.left.equalToSuperview()
            $0.size.equalTo(StaticSize.s20)
            $0.centerY.equalToSuperview()
        })
        
        addSubview(profileButton)
        profileButton.snp.makeConstraints({
            $0.right.equalToSuperview()
            $0.size.equalTo(StaticSize.s20)
            $0.centerY.equalToSuperview()
        })
        
        addSubview(addressView)
        addressView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalTo(editButton.snp.right).offset(StaticSize.s15)
            $0.right.equalTo(profileButton.snp.left).offset(-StaticSize.s15)
            $0.top.bottom.equalToSuperview().inset(StaticSize.s5)
        })
        
        addSubview(addressLabel)
        addressLabel.snp.makeConstraints({
            $0.bottom.equalTo(addressView.snp.top).offset(StaticSize.s15)
            $0.left.equalTo(addressView)
        })
    }
    
    func setText(text: String){
        addressView.text = text
    }
    
    @objc func openProfile(sender: UIButton){
        if let vc = viewContainingController(){
            vc.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
}
