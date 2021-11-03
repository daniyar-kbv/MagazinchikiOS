//
//  UILabel.swift
//  Samokat
//
//  Created by Daniyar on 8/4/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    internal func setUpStatus(status: StatusNames) {
        switch status {
        case .created:
            self.textColor = .customStatusYellow
            self.text = "В работе"
        case .canceled:
            self.textColor = .customStatusRed
            self.text = "Отменен"
        case .completed:
            self.textColor = .customStatusGreen
            self.text = "Доставлен"
        default:
            self.textColor = .customStatusYellow
            self.text = "В работе"
        }
    }
}

enum StatusNames: String {
    case created = "CREATED"
    case canceled = "CANCELED"
    case completed = "COMPLETED"
}
