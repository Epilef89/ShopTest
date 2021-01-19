//
//  StringExtension.swift
//  ShopTest
//
//  Created by david cortes on 18/01/21.
//

import Foundation


extension String{
    
    func getFormatNumber(withDecimal:Bool, separator:String, decimalSeparator:String)->String{
        var components:[String] = []
        var text = self
        if self.contains(separator){
            components = self.components(separatedBy: separator)
            text = components[0]
        }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .none
        currencyFormatter.groupingSize = 3
        currencyFormatter.groupingSeparator = separator
        let string = text.replacingOccurrences(of: separator, with: "")
        if string == "0" && components.count < 2 && !withDecimal{
            return ""
        }else{
            let number = NSNumber(integerLiteral: Int(string) ?? 0 )
            let priceString = currencyFormatter.string(from: number)
            if components.count > 1{
                if String(components[1]).count < 2{
                    return "\(priceString ?? "")\(decimalSeparator)\(components[1])0"
                }else{
                    return "\(priceString ?? "")\(decimalSeparator)\(components[1])"
                }
                
            }else{
                if withDecimal{
                    return "\(priceString ?? "")\(decimalSeparator)00"
                }else{
                    return priceString ?? ""
                }
            }
        }
        
    }
    
    

}
