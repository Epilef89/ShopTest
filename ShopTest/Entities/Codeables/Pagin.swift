//
//  Pagin.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct Paging: Codable {
    let total, offset, limit, primaryResults: Int?

    enum CodingKeys: String, CodingKey {
        case total, offset, limit
        case primaryResults = "primary_results"
    }
    
    public init(from decoder: Decoder) throws {
        let paginResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        total =  try paginResultsValues.decodeIfPresent(Int.self, forKey: .total)
        offset =  try paginResultsValues.decodeIfPresent(Int.self, forKey: .offset)
        limit =  try paginResultsValues.decodeIfPresent(Int.self, forKey: .limit)
        primaryResults =  try paginResultsValues.decodeIfPresent(Int.self, forKey: .primaryResults)
    }
}

