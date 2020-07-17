//
//  PaymentTypeModalViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class PaymentTypeModalViewController: CustomModalViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var paymentsModalView = PaymentTypeModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalView.setView(view: paymentsModalView)
        
        paymentsModalView.tableView.delegate = self
        paymentsModalView.tableView.dataSource = self
    }
    
    override func loadView() {
        super.loadView()
        
        view = modalView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTypeCell.customReuseIdentifier, for: indexPath) as! PaymentTypeCell
        cell.setTitle(text: paymentTypes[indexPath.row])
        if indexPath.row == 1{
            cell.cardView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<paymentTypes.count{
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! PaymentTypeCell
            cell.select(i == indexPath.row)
        }
    }
}

