//
//  String.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension String {
    internal func format(mask: String = "+X XXX XXX XX XX") -> String {
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    internal func changeSubstringFont(lastElement: String, font: UIFont) -> NSAttributedString{
        let firstIndex = self.index(self.startIndex, offsetBy: 12)
        let lastIndex = self.range(of: lastElement)
        let substring = self[firstIndex...lastIndex!.lowerBound]
        return self.substringFont(substring: String(substring), changedFont: font)
    }
    
    internal func substringFont(substring: String, changedFont: UIFont) -> NSAttributedString{
        let longestWord = substring
        let longestWordRange = (self as NSString).range(of: longestWord)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.setAttributes([NSAttributedString.Key.font: changedFont], range: longestWordRange)
        return attributedString
    }
}
