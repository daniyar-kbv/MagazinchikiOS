//
//  OrdersViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class OrdersViewController: UIViewController {
    lazy var ordersView = OrdersView()
    lazy var viewModel = OrdersViewModel()
    lazy var disposeBag = DisposeBag()
    var orders: [Order]? {
        didSet {
            ordersView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = ordersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersView.tableView.delegate = self
        ordersView.tableView.dataSource = self
        
        ordersView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        bind()
        viewModel.getOrders()
    }
    
    func bind() {
        viewModel.orders.subscribe(onNext: { orders in
            DispatchQueue.main.async {
                self.orders = orders
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func backTapped(){
        dismiss(animated: true, completion: nil)
    }
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.customReuseIdentifier, for: indexPath) as! OrderCell
        cell.order = orders?[indexPath.row]
        cell.contentView.isUserInteractionEnabled = true
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderDetailViewController()
        vc.order = orders?[indexPath.row]
        openTop(vc: vc)
    }
}
