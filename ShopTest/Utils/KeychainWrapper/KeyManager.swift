//
//  KeyManager.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import Foundation
import SwiftKeychainWrapper


struct KeyManager {
    

    func set(country: String) {
        KeychainWrapper.standard.set(country, forKey: DefaultKeys.country.rawValue)
    }
    
    func getCountry() -> String? {
        return KeychainWrapper.standard.string(forKey: DefaultKeys.country.rawValue)
    }
    
    func clear(){
        set(country: "")
    }
    
    private enum DefaultKeys:String{
        case country
    }
    
    
}


