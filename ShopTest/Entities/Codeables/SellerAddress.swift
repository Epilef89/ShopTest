//
//  SellerAddress.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct SellerAddress: Codable {
    let id, comment, addressLine, zipCode: String?
    let country, state, city: Description?
    let latitude, longitude: String?

    enum CodingKeys: String, CodingKey {
        case id, comment
        case addressLine = "address_line"
        case zipCode = "zip_code"
        case country, state, city, latitude, longitude
    }
    
    public init(from decoder: Decoder) throws {
        let sellerAddressResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        id =  try sellerAddressResultsValues.decodeIfPresent(String.self, forKey: .id)
        comment =  try sellerAddressResultsValues.decodeIfPresent(String.self, forKey: .comment)
        addressLine = try sellerAddressResultsValues.decodeIfPresent(String.self, forKey: .addressLine)
        zipCode =  try sellerAddressResultsValues.decodeIfPresent(String.self, forKey: .zipCode)
        country =  try sellerAddressResultsValues.decodeIfPresent(Description.self, forKey: .country)
        state =  try sellerAddressResultsValues.decodeIfPresent(Description.self, forKey: .state)
        city =  try sellerAddressResultsValues.decodeIfPresent(Description.self, forKey: .city)
        latitude =  try sellerAddressResultsValues.decodeIfPresent(String.self, forKey: .latitude)
        longitude =  try sellerAddressResultsValues.decodeIfPresent(String.self, forKey: .longitude)

    }
    
    
}
