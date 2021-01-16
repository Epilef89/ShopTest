//
//  UIFontExtension.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import UIKit

extension UIFont {
    
    class func getFont(_ fontType:FontType, size:CGFloat)->UIFont{
        guard let font = UIFont(name: fontType.rawValue, size: size)
            else {
            fatalError("fatal error \(fontType.rawValue) not found")
        }
        
        return font
    }
    
    enum FontType:String{
        case bold = "Intro-Bold"
        case light = "Intro-Light"
        case regular = "Intro-Regular"
    }
}
