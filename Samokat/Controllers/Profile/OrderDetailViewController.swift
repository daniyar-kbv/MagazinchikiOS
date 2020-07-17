//
//  OrderDetailViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class OrderDetailViewController: UIViewController {
    lazy var orderView = OrderDetailView()
    
    override func loadView() {
        super.loadView()
        
        view = orderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderView.tableView.delegate = self
        orderView.tableView.dataSource = self
        
        configActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        orderView.tableView.snp.makeConstraints({
            $0.height.equalTo(orderView.rowHeight * CGFloat(orderView.tableView.numberOfRows(inSection: 0)))
        })
    }
    
    func configActions(){
        orderView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        orderView.billButton.addTarget(self, action: #selector(openBill), for: .touchUpInside)
    }
    
    @objc func backTapped(){
        removeTop()
    }
    
    @objc func openBill(){
        openTop(vc: BillViewController())
    }
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailCell.customReuseIdentifier, for: indexPath)
        return cell
    }
}
