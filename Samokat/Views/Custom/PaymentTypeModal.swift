//
//  PaymentTypeModal.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class PaymentTypeModalView: UIView{
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(PaymentTypeCell.self, forCellReuseIdentifier: PaymentTypeCell.customReuseIdentifier)
        view.delaysContentTouches = false
        view.separatorStyle = .none
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([tableView])
        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}
