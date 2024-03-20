//
//  UITextField+.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/20/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func addLeftPadding(_ value: Double) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
