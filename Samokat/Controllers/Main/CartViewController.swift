//
//  CartViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class CartViewController: UIViewController {
    lazy var viewModel = CartViewModel()
    lazy var cartView = CartView()
    var cart: Cart = AppShared.sharedInstance.cart {
        didSet{
            if cart.items?.count == 0{
                dismiss(animated: true, completion: nil)
            }
            cartView.sumView.setValues("\((cart.totalPrice ?? 0).formattedWithSeparator) ₸", "\((Double(cart.totalPrice ?? 0) * 0.1).formattedWithSeparator) ₸", "- 10%")
            cartView.tableView.reloadData()
            makeTableHeight()
        }
    }
    lazy var disposeBag = DisposeBag()
    var paymentType: PaymentTypes = .cash {
        didSet {
            switch paymentType {
            case .cash:
                cartView.paymentTypeButton.setBottom(text: paymentTypes[2])
            case .card:
                cartView.paymentTypeButton.setBottom(text: paymentTypes[1])
            case .kaspi:
                cartView.paymentTypeButton.setBottom(text: paymentTypes[0])
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
        
        navigationController?.delegate = self
        
        configActions()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppShared.sharedInstance.navigationController.delegate = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        makeTableHeight()
    }
    
    func bind(){
        AppShared.sharedInstance.cartSubject.subscribe(onNext: {cart in
            self.cart = cart
        }).disposed(by: disposeBag)
        viewModel.orderId.subscribe(onNext: { orderId in
            DispatchQueue.main.async {
                AppShared.sharedInstance.cart.clear()
                self.dismiss(animated: true, completion: {
                    let nav = AppShared.sharedInstance.navigationController
                    let vc = OrderFormingViewController()
                    vc.orderId = orderId
                    nav?.pushViewController(vc, animated: true)
                    nav?.delegate = nil
                })
            }
        }).disposed(by: disposeBag)
    }
    
    func configActions(){
        cartView.paymentTypeButton.addTarget(self, action: #selector(openPaymentsModal), for: .touchUpInside)
        cartView.promocodeButton.addTarget(self, action: #selector(openPromocodeModal), for: .touchUpInside)
        cartView.bottomButton.addTarget(self, action: #selector(orderTapped), for: .touchUpInside)
    }
    
    @objc func orderTapped(){
        viewModel.createOrder(payment: paymentType)
    }
    
    func makeTableHeight(){
        cartView.tableView.snp.makeConstraints({
            $0.height.equalTo(cartView.tableView.rowHeight * CGFloat(cartView.tableView.numberOfRows(inSection: 0)))
        })
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.customReuseIdentifier) as! CartTableViewCell
        cell.product = cart.items?[indexPath.row].product
        return cell
    }
}

extension CartViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is OrderResultViewController{
            AppShared.sharedInstance.navigationController.isNavigationBarHidden = true
        }
    }
}
