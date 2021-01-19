//
//  ErrorExtension.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

extension NSError {
    func getErrorMessage() -> String {
        return userInfo["message"] as? String ?? ""
    }
}
