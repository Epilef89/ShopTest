//
//  PrintCustom.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct PrintCustom {
    static func printDebug(toPrint: Any) {
        
        #if DEBUG || Develop || QA
            print(toPrint)
        #endif
    }
}
