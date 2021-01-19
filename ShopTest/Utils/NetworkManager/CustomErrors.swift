//
//  CustomErrors.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

let kErrorGeneralResponse = 8000
let kErrorNetworkConection = 8001
let KErrorOutOfRange = 8002
let KEnoDataFound = 8004


struct CustomErrors {
     static let errorGeneralResponse = NSError(domain: "8000",
                                       code: kErrorGeneralResponse,
                                       userInfo: ["message":
                                        NSLocalizedString("errorMessage.GeneralResponse",
                                                          comment: "")])

    static let errorNetworkConection = NSError(domain: "8001",
                                              code: kErrorNetworkConection,
                                              userInfo: ["message":
                                                NSLocalizedString("errorMessage.NetworkConexion",
                                                                  comment: "")])
    static let errorOffsetOutOffRange = NSError(domain: "8002",
                                                code: KErrorOutOfRange,
                                                userInfo: ["message":NSLocalizedString("errorMessage.GeneralResponse",
                                                                                       comment: "")])
    static let errorNoData = NSError(domain: "8002",
                                                code: KEnoDataFound,
                                                userInfo: ["message":NSLocalizedString("errorMessage.NoData",
                                                                                       comment: "")])
    
}

