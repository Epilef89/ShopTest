//
//  Seller.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct Seller: Codable {
    let id: Int?
    let powerSellerStatus: String?
    let carDealer, realEstateAgency: Bool?
    let tags: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case powerSellerStatus = "power_seller_status"
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
        case tags
    }
    
    public init(from decoder: Decoder) throws {
        let sellerResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        id =  try sellerResultsValues.decodeIfPresent(Int.self, forKey: .id)
        powerSellerStatus =  try sellerResultsValues.decodeIfPresent(String.self, forKey: .powerSellerStatus)
        carDealer =  try sellerResultsValues.decodeIfPresent(Bool.self, forKey: .carDealer)
        realEstateAgency =  try sellerResultsValues.decodeIfPresent(Bool.self, forKey: .realEstateAgency)
        tags =  try sellerResultsValues.decodeIfPresent([String].self, forKey: .tags)
    }
}
