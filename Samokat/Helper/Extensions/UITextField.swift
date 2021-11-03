//
//  UITextField.swift
//  Samokat
//
//  Created by Daniyar on 7/22/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func isEmpty() -> Bool {
        return self.text?.count == 0
    }
}
