//
//  Description.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct Description: Codable {
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    public init(from decoder: Decoder) throws {
        let descriptionValues = try decoder.container(keyedBy: CodingKeys.self)
        id =  try descriptionValues.decodeIfPresent(String.self, forKey: .id)
        name =  try descriptionValues.decodeIfPresent(String.self, forKey: .name)
    }
}
