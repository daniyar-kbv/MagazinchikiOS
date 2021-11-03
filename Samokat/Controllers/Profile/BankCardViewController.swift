//
//  BankCardViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class BankCardViewController: UIViewController, UITextFieldDelegate {
    lazy var cardView =  BankCardView()
    
    override func loadView() {
        super.loadView()
        
        view = cardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.cardField.delegate = self
        cardView.expireField.delegate = self
        cardView.cvvField.delegate = self
        
        cardView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cardView.cardField.becomeFirstResponder()
    }
    
    @objc func backTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        switch textField {
        case cardView.cardField:
            textField.text = newString.format(mask: "XXXX XXXX XXXX XXXX")
        case cardView.expireField:
            textField.text = newString.format(mask: "XX/XX")
        case cardView.cvvField:
            textField.text = newString.format(mask: "XXX")
        default:
            break
        }
        return false
    }
}
