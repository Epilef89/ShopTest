//
//  Shipping.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct Shipping: Codable {
    let freeShipping: Bool?
    let mode: String?
    let tags: [String]?
    let logisticType: String?
    let storePickUp: Bool?

    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case mode, tags
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
    }
    
    public init(from decoder: Decoder) throws {
        let shippingResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        freeShipping =  try shippingResultsValues.decodeIfPresent(Bool.self, forKey: .freeShipping)
        mode =  try shippingResultsValues.decodeIfPresent(String.self, forKey: .mode)
        tags =  try shippingResultsValues.decodeIfPresent([String].self, forKey: .tags)
        logisticType =  try shippingResultsValues.decodeIfPresent(String.self, forKey: .logisticType)
        storePickUp =  try shippingResultsValues.decodeIfPresent(Bool.self, forKey: .storePickUp)
    }
}
