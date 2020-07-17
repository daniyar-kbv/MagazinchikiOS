//
//  UIFont.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func roboto(style: FontStyles, size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-\(style)", size: size)!
    }
    
    class func sfProBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SFProDisplay-Bold", size: size)!
    }
}
