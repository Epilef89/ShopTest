//
//  UIColorExtension.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import Foundation
import UIKit

// Color palette
extension UIColor {
    
    @nonobjc class var yellowMainColor: UIColor {
        return UIColor(red: 250.0/255.0, green: 230.0/255.0, blue: 77.0/255.0, alpha: 1.0)
    }
    
    @nonobjc class var blueMainColor: UIColor {
        return UIColor(red: 46.0 / 255.0, green: 50.0 / 225.0, blue: 115.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayMainColor: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var transparentBackgroundAlert: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0, alpha: 0.5)
    }
    
    @nonobjc class var greenFreeShipping: UIColor {
        return UIColor(red: 113 / 255.0, green: 228 / 255.0, blue: 119/255, alpha: 0.5)
    }
    
    @nonobjc class var grayDark: UIColor {
        return UIColor(red: 180 / 255.0, green: 180 / 255.0, blue: 180 / 255.0, alpha: 1.0)
    }
}
