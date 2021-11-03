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
import RxSwift

class AddressView: UIView {
    lazy var disposeBag = DisposeBag()
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
        view.addTarget(self, action: #selector(editAddressPressed), for: .touchUpInside)
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
        view.text = AppShared.sharedInstance.address?.getAddress()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        profileButton.addTarget(self, action: #selector(openProfile(sender:)), for: .touchUpInside)
        
        setUp()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        AppShared.sharedInstance.addressSubject.subscribe(onNext: { address in
            DispatchQueue.main.async {
                self.addressView.text = address.getAddress()
            }
        }).disposed(by: disposeBag)
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
    
    @objc func editAddressPressed(){
        guard let vc = viewContainingController() else { return }
        vc.dismiss(animated: true, completion: nil)
        let toVc = LocationViewController()
        toVc.fromMain = true
        AppShared.sharedInstance.navigationController.pushViewController(toVc, animated: true)
    }
}
