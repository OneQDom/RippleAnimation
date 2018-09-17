//
//  UIColorExtension.swift
//  RippleAnimation
//
//  Created by WQ on 2017/4/7.
//  Copyright © 2017年 WQ. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex6: Int) {
        self.init(hex8: (Int64(hex6) << 8) + 0xFF)
    }

    convenience init(hex8: Int64) {
        var rgb = hex8
        let alpha = rgb & 0xFF
        rgb >>= 8
        let blue = rgb & 0xFF
        rgb >>= 8
        let green = rgb & 0xFF
        rgb >>= 8
        self.init(red: CGFloat(rgb) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
}
