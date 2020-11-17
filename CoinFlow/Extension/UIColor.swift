//
//  UIColor.swift
//  CoinFlow
//
//  Created by KeunHyeong on 2020/11/14.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

extension UIColor{
    static func randomColor() -> UIColor{
        let colors:[UIColor] = [.systemRed, .systemBlue, .systemPink, .systemTeal, .systemGreen,.systemYellow, .systemOrange]
        
        let randomColor = colors.randomElement()!
        return randomColor
    }
}
