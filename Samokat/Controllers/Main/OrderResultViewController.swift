//
//  OrderResultViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class OrderResultViewController: UIViewController {
    lazy var resultView = OrderResultView()
    var type: OrderRusultType? {
        didSet{
            resultView.type = type
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configActions()
    }
    
    func configActions(){
        switch type {
        case .success:
            resultView.firstButton.addTarget(self, action: #selector(toOrders), for: .touchUpInside)
        case .failure:
            resultView.firstButton.addTarget(self, action: #selector(toCart), for: .touchUpInside)
            resultView.secondButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        case .none:
            break
        }
    }
        
    @objc func toOrders(){
        DispatchQueue.main.async {
            let nav = AppShared.sharedInstance.navigationController
            for _ in 0..<self.toMainCount(){
                nav?.popViewController(animated: false)
            }
            let profileVc = ProfileViewController()
            nav?.pushViewController(profileVc, animated: false)
            profileVc.present(OrdersViewController(), animated: true, completion: nil)
        }
    }
    
    @objc func toCart(){
        DispatchQueue.main.async {
            let nav = AppShared.sharedInstance.navigationController
            for _ in 0..<self.toMainCount(){
                nav?.popViewController(animated: false)
            }
            UIApplication.topViewController()?.present(CartViewController(), animated: true, completion: nil)
        }
    }
    
    @objc func cancel(){
        DispatchQueue.main.async {
            let nav = AppShared.sharedInstance.navigationController
            for _ in 0..<self.toMainCount() - 1{
                nav?.popViewController(animated: false)
            }
            nav?.popViewController(animated: true)
        }
    }
    
    func toMainCount() -> Int {
        let nav = AppShared.sharedInstance.navigationController
        guard let vcs = nav?.viewControllers else { return 2 }
        var found = false
        var count = 0
        for vc in vcs{
            if found {
                count += 1
            }
            if vc is MainPageViewController{
                found = true
            }
        }
        return count
    }
}
