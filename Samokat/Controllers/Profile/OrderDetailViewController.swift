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
    var order: Order? {
        didSet {
            orderView.order = order
        }
    }
    
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
        let vc = BillViewController()
        vc.order = order
        openTop(vc: vc)
    }
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailCell.customReuseIdentifier, for: indexPath) as! OrderDetailCell
        cell.product = order?.products?[indexPath.row]
        return cell
    }
}
