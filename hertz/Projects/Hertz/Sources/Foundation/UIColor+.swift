//
//  UIColor+.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/12/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    static let white = UIColor(0xFFFFFF)
    static let black = UIColor(0x000000)
    
    static let gray100 = UIColor(0xF4F5F9)
    static let gray200 = UIColor(0xF1F1F1)
    static let gray300 = UIColor(0xE6E6E6)
    static let gray400 = UIColor(0xD1D1D1)
    static let gray500 = UIColor(0xAAAAAA)
    static let gray600 = UIColor(0x787878)
    static let gray700 = UIColor(0x333333)
    static let gray800 = UIColor(0x1D1D1D)
    
    static let shadow = UIColor(0x000000)
}


extension UIColor {
    
    convenience init(_ rgbValue: UInt64, alpha: CGFloat = 1.0) {
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
