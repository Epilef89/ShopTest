//
//  Attribute.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct Attribute: Codable {
    let name:String?
    let valueName:String?
    let valueID:String?
    let attributeGroupID:String?
    let attributeGroupName:String?
    let source: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name
        case valueID = "value_id"
        case valueName = "value_name"
        case attributeGroupID = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case source, id
    }
    
    public init(from decoder: Decoder) throws {
        let attributeResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        name =  try attributeResultsValues.decodeIfPresent(String.self, forKey: .name)
        valueID =  try attributeResultsValues.decodeIfPresent(String.self, forKey: .valueID)
        valueName =  try attributeResultsValues.decodeIfPresent(String.self, forKey: .valueName)
        attributeGroupID =  try attributeResultsValues.decodeIfPresent(String.self, forKey: .attributeGroupID)
        attributeGroupName =  try attributeResultsValues.decodeIfPresent(String.self, forKey: .attributeGroupName)
        source =  try attributeResultsValues.decodeIfPresent(Int.self, forKey: .source)
        id =  try attributeResultsValues.decodeIfPresent(String.self, forKey: .id)
    }
}
