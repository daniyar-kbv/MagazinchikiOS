//
//  OrdersViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class OrdersViewController: UIViewController {
    lazy var ordersView = OrdersView()
    
    override func loadView() {
        super.loadView()
        
        view = ordersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersView.tableView.delegate = self
        ordersView.tableView.dataSource = self
        
        ordersView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    @objc func backTapped(){
        dismiss(animated: true, completion: nil)
    }
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.customReuseIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openTop(vc: OrderDetailViewController())
    }
}
