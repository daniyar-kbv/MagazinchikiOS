//
//  UIStackView.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubViews(_ subviews: [UIView]) {
        for view in subviews{
            addArrangedSubview(view)
        }
    }
}
