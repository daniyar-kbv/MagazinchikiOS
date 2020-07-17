//
//  BillVIewController.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class BillViewController: UIViewController {
    lazy var billView = BillView()
    
    override func loadView() {
        super.loadView()
        
        view = billView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configActions()
    }
    
    func configActions(){
        billView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    @objc func backTapped(){
        removeTop()
    }
}
