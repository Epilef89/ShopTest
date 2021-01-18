//
//  Address.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct Address: Codable {
    let stateID:String?
    let stateName:String?
    let cityID:String?
    let cityName: String?

    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "state_name"
        case cityID = "city_id"
        case cityName = "city_name"
    }
    
    public init(from decoder: Decoder) throws {
        let addressResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        stateID =  try addressResultsValues.decodeIfPresent(String.self, forKey: .stateID)
        stateName =  try addressResultsValues.decodeIfPresent(String.self, forKey: .stateName)
        cityID =  try addressResultsValues.decodeIfPresent(String.self, forKey: .cityID)
        cityName =  try addressResultsValues.decodeIfPresent(String.self, forKey: .cityName)
    }
}
