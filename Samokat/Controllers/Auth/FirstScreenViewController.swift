//
//  ViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {
    lazy var firstScreenView = FirstScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configActions()
    }
    
    override func loadView() {
        super.loadView()
        
        view = firstScreenView
    }
    
    func configActions() {
        firstScreenView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    @objc func nextTapped(){
        navigationController?.pushViewController(LocationViewController(), animated: true)
    }

}

