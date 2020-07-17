//
//  PromocodeModalViewConstroller.swift
//  Samokat
//
//  Created by Daniyar on 7/11/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class PromocodeModalViewController: CustomModalViewController {
    lazy var promocodeModal = PromocodeModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalView.setView(view: promocodeModal)
        
        keyboardDisplay()
        hideKeyboardWhenTappedAround()
        
        promocodeModal.bottomButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        promocodeModal.field.becomeFirstResponder()
    }
    
    @objc func buttonTapped(){
        promocodeModal.field.resignFirstResponder()
    }
}
