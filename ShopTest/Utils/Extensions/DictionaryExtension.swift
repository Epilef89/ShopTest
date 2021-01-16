//
//  DictionaryExtension.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import Foundation

extension Dictionary  {
    func stringFromHttpParameters() -> String {
        
        var parametersString = ""
        for (key, value) in self {
            if let key = key as? String,
                let value = value as? String {
                parametersString += key.description + "=" + value.description + "&"
            }
        }
        parametersString = String(parametersString.dropLast())
        return parametersString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
