//
//  UIColor.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
//  MARK: Colors
    
    static let customTextBlack = UIColor(hex: "#4B4B4B")
    static let customLightBlue = UIColor(hex: "#EFF5FB")
    static let customGray = UIColor(hex: "#E5E5E5")
    static let customLightGray = UIColor(hex: "#BFBFBF")
    static let customGreen = UIColor(hex: "#95C88D")
    static let customStatusGreen = UIColor(hex: "#95C88D")
    static let customStatusRed = UIColor(hex: "#EB4724")
    static let customStatusYellow = UIColor(hex: "#FFCC16")
    
//  MARK: Methods
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if (hex.hasPrefix("#")) {
            scanner.currentIndex = String.Index(utf16Offset: 1, in: hex)
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
