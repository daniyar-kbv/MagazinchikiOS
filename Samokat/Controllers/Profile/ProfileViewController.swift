//
//  ProfileViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController{
    lazy var profileView = ProfileView()
    
    override func loadView() {
        super.loadView()
        
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        
        addBackButton()
        configActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.delegate = self
    }
    
    func configActions(){
        profileView.cardLabel.addTarget(self, action: #selector(openCardView), for: .touchUpInside)
        profileView.ordersLabel.addTarget(self, action: #selector(openOrders), for: .touchUpInside)
    }
    
    @objc func openCardView(){
        navigationController?.present(BankCardViewController(), animated: true)
    }
    
    @objc func openOrders(){
        navigationController?.present(OrdersViewController(), animated: true, completion: nil)
    }
}

extension ProfileViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is MainPageViewController{
            AppShared.sharedInstance.navigationController.isNavigationBarHidden = true
            AppShared.sharedInstance.navigationController.delegate = nil
        }
    }
}
