//
//  Global.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit


class Global {

    //MARK: - Safe area
    static let keyWindow = AppShared.sharedInstance.keyWindow
    
    class func safeAreaTop() -> CGFloat {
        var window = keyWindow
        if #available(iOS 11.0, *), let keyWindow = window {
            var area = keyWindow.safeAreaInsets.top
            if  area == 0 { area = 20 }
            return area
        } else {
            return 0
        }
    }

    class func safeAreaBottom() -> CGFloat{
        var window = keyWindow
        if window == nil{
            window = AppShared.sharedInstance.keyWindow
        }
        if #available(iOS 11.0, *), let keyWindow = window{
            var area = keyWindow.safeAreaInsets.bottom
            if area == 0 { area = 20 }
            return area
        } else {
            return 20
        }
    }
}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct StaticSize {
    static let s14 = ScreenSize.SCREEN_WIDTH / 26.7
    static let s13 = ScreenSize.SCREEN_WIDTH / 24.8
    static let s30 = ScreenSize.SCREEN_WIDTH / 12.5
    static let s44 = ScreenSize.SCREEN_WIDTH / 8.5
    static let s18 = ScreenSize.SCREEN_WIDTH / 20.8
    static let s20 = ScreenSize.SCREEN_WIDTH / 18.75
    static let s16 = ScreenSize.SCREEN_WIDTH / 23.4
    static let s12 = ScreenSize.SCREEN_WIDTH / 31.25
    static let s19 = ScreenSize.SCREEN_WIDTH / 19.7
    static let s60 = ScreenSize.SCREEN_WIDTH / 6.25
    static let s76 = ScreenSize.SCREEN_WIDTH / 4.93
    static let s9  = ScreenSize.SCREEN_WIDTH / 41.6
    static let s260 = ScreenSize.SCREEN_WIDTH / 1.44
    static let s150 = ScreenSize.SCREEN_WIDTH / 2.5
    static let s22 = ScreenSize.SCREEN_WIDTH / 17
    static let s17 = ScreenSize.SCREEN_WIDTH / 22
    static let s100 = ScreenSize.SCREEN_WIDTH / 3.75
    static let s28 = ScreenSize.SCREEN_WIDTH / 13.39
    static let s118 = ScreenSize.SCREEN_WIDTH / 3.23 + 2
    static let s23 = ScreenSize.SCREEN_WIDTH / 16.3
    static let s36 = ScreenSize.SCREEN_WIDTH / 10.4
    static let s34 = ScreenSize.SCREEN_WIDTH / 11
    static let s40 = ScreenSize.SCREEN_WIDTH / 9.375
    static let s10 = ScreenSize.SCREEN_WIDTH / 37.5
    static let s240 = ScreenSize.SCREEN_WIDTH / 1.56
    static let s135 = ScreenSize.SCREEN_WIDTH / 2.7
    static let s184 = ScreenSize.SCREEN_WIDTH / 2
    static let s316 = ScreenSize.SCREEN_WIDTH / 1.18
    static let s75 = ScreenSize.SCREEN_WIDTH / 5
    static let s50 = ScreenSize.SCREEN_WIDTH / 7.5
    static let s86 = ScreenSize.SCREEN_WIDTH / 4.36
    static let s15 = ScreenSize.SCREEN_WIDTH / 25
    static let s42 = ScreenSize.SCREEN_WIDTH / 8.92
    static let s11 = ScreenSize.SCREEN_WIDTH / 34
    static let s57 = ScreenSize.SCREEN_WIDTH / 6.81 + 2
    static let s46 = ScreenSize.SCREEN_WIDTH / 8.15
    static let s70 = ScreenSize.SCREEN_WIDTH / 5.357
    static let s55 = ScreenSize.SCREEN_WIDTH / 6.81
    static let s128 = ScreenSize.SCREEN_WIDTH / 2.92
    static let s140 = ScreenSize.SCREEN_WIDTH / 2.67
    static let s188 = ScreenSize.SCREEN_WIDTH / 1.99
    static let s90 = ScreenSize.SCREEN_WIDTH / 4.16
    static let s80 = ScreenSize.SCREEN_WIDTH / 4.68
    static let s26 = ScreenSize.SCREEN_WIDTH / 14.42
    static let s138 = ScreenSize.SCREEN_WIDTH / 2.71
    static let s115 = ScreenSize.SCREEN_WIDTH / 3.26
    static let s8 = ScreenSize.SCREEN_WIDTH / 46.875
    static let s105 = ScreenSize.SCREEN_WIDTH / 3.57
    static let s25 = ScreenSize.SCREEN_WIDTH / 15
    static let s227 = ScreenSize.SCREEN_WIDTH / 1.65
    static let s160 = ScreenSize.SCREEN_WIDTH / 2.34
    static let s194 = ScreenSize.SCREEN_WIDTH / 1.93
    static let s276 = ScreenSize.SCREEN_WIDTH / 1.35
    static let s121 = ScreenSize.SCREEN_WIDTH / 3.1
    static let s218 = ScreenSize.SCREEN_WIDTH / 1.72
    static let s174 = ScreenSize.SCREEN_WIDTH / 2.15
    static let s200 = ScreenSize.SCREEN_WIDTH / 1.875
    static let s5 = ScreenSize.SCREEN_WIDTH / 75
    static let s3 = ScreenSize.SCREEN_WIDTH / 125
    static let s295 = ScreenSize.SCREEN_WIDTH / 1.27
    static let s1 = ScreenSize.SCREEN_WIDTH / 375
    static let buttonHeight = s50
}
