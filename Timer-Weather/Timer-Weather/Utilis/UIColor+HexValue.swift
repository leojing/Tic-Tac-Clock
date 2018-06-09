//
//  UIColor+HexValue.swift
//  Timer-Weather
//
//  Created by JINGLUO on 29/4/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import UIKit

extension UIColor {
    
    func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func hexStringToUIColor(hex:String, r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: (CGFloat((rgbValue & 0xFF0000) >> 16) - r) / 255.0,
            green: (CGFloat((rgbValue & 0x00FF00) >> 8) - g) / 255.0,
            blue: (CGFloat(rgbValue & 0x0000FF) - b) / 255.0,
            alpha: CGFloat(alpha)
        )
    }

}
