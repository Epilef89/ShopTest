//
//  SearchResults.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct SearchResults: Codable {
    
    let siteID:String?
    let query:String?
    let paging:Paging?
    let results:[ResultSearch]?

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case query = "query"
        case paging = "paging"
        case results = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let searchResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        siteID =  try searchResultsValues.decodeIfPresent(String.self, forKey: .siteID)
        query =  try searchResultsValues.decodeIfPresent(String.self, forKey: .query)
        paging =  try searchResultsValues.decodeIfPresent(Paging.self, forKey: .paging)
        results =  try searchResultsValues.decodeIfPresent([ResultSearch].self, forKey: .results)
        
    }
}
