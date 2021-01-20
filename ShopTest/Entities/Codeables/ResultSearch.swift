//
//  Results.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct ResultSearch: Codable {
    let id, siteID, title: String?
    let seller: Seller?
    let price: Double?
    let currencyID: String?
    let availableQuantity, soldQuantity: Int?
    let buyingMode, listingTypeID, stopTime, condition: String?
    let permalink: String?
    let thumbnail: String?
    let acceptsMercadopago: Bool?
    let installments: Installments?
    let address: Address?
    let shipping: Shipping?
    let sellerAddress: SellerAddress?
    let attributes: [Attribute]?
    let categoryID: String?
    let officialStoreID: Int?
    let catalogProductID: String?
    let tags: [String]?
    let catalogListing: Bool?
    var priceDisplaypriceDisplay:String{
        return "$\(String(price ?? 0).getFormatNumber(withDecimal: true, separator: ".", decimalSeparator: ",")) (\(currencyID?.lowercased() ?? ""))"
    }
    var conditionDisplay:String{
        return NSLocalizedString(condition ?? "", comment: "")
    }
    var availableProductsDisplay:String{
        return " \(NSLocalizedString("detailView.AvailabeProducts.label", comment: "")) | \(availableQuantity ?? 0)"
    }
    
    var soldQuantityProductDisplay:String{
        return " \(NSLocalizedString("detailView.SoldProductos.label", comment: "")) | \(soldQuantity ?? 0)"
    }
    var typeShipping:String{
        guard let shipping = shipping else{
            return ""
        }
        return (shipping.freeShipping ?? false ? NSLocalizedString("detailView.FreeShipping.label", comment: "") : "")
    }

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title, seller, price
        case currencyID = "currency_id"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case buyingMode = "buying_mode"
        case listingTypeID = "listing_type_id"
        case stopTime = "stop_time"
        case condition, permalink, thumbnail
        case acceptsMercadopago = "accepts_mercadopago"
        case installments, address, shipping
        case sellerAddress = "seller_address"
        case attributes
        case categoryID = "category_id"
        case officialStoreID = "official_store_id"
        case catalogProductID = "catalog_product_id"
        case tags
        case catalogListing = "catalog_listing"
    }
    
    public init(from decoder: Decoder) throws {
        let resultsValues = try decoder.container(keyedBy: CodingKeys.self)
        id =  try resultsValues.decodeIfPresent(String.self, forKey: .id)
        siteID =  try resultsValues.decodeIfPresent(String.self, forKey: .siteID)
        title =  try resultsValues.decodeIfPresent(String.self, forKey: .title)
        seller =  try resultsValues.decodeIfPresent(Seller.self, forKey: .seller)
        price =  try resultsValues.decodeIfPresent(Double.self, forKey: .price)
        currencyID =  try resultsValues.decodeIfPresent(String.self, forKey: .currencyID)
        availableQuantity =  try resultsValues.decodeIfPresent(Int.self, forKey: .availableQuantity)
        soldQuantity =  try resultsValues.decodeIfPresent(Int.self, forKey: .soldQuantity)
        buyingMode =  try resultsValues.decodeIfPresent(String.self, forKey: .buyingMode)
        listingTypeID =  try resultsValues.decodeIfPresent(String.self, forKey: .listingTypeID)
        stopTime =  try resultsValues.decodeIfPresent(String.self, forKey: .stopTime)
        condition =  try resultsValues.decodeIfPresent(String.self, forKey: .condition)
        permalink =  try resultsValues.decodeIfPresent(String.self, forKey: .permalink)
        thumbnail =  try resultsValues.decodeIfPresent(String.self, forKey: .thumbnail)
        acceptsMercadopago =  try resultsValues.decodeIfPresent(Bool.self, forKey: .acceptsMercadopago)
        installments =  try resultsValues.decodeIfPresent(Installments.self, forKey: .installments)
        address =  try resultsValues.decodeIfPresent(Address.self, forKey: .address)
        shipping =  try resultsValues.decodeIfPresent(Shipping.self, forKey: .shipping)
        sellerAddress = try resultsValues.decodeIfPresent(SellerAddress.self, forKey: .sellerAddress)
        attributes =  try resultsValues.decodeIfPresent([Attribute].self, forKey: .attributes)
        categoryID =  try resultsValues.decodeIfPresent(String.self, forKey: .categoryID)
        officialStoreID =  try resultsValues.decodeIfPresent(Int.self, forKey: .officialStoreID)
        catalogProductID =  try resultsValues.decodeIfPresent(String.self, forKey: .catalogProductID)
        tags =  try resultsValues.decodeIfPresent([String].self, forKey: .tags)
        catalogListing =  try resultsValues.decodeIfPresent(Bool.self, forKey: .catalogListing)
        
    }
    
    public init(){
        id = nil
        siteID = nil
        title = nil
        seller = nil
        price = nil
        currencyID = nil
        availableQuantity = nil
        soldQuantity = nil
        buyingMode = nil
        listingTypeID = nil
        stopTime = nil
        condition = nil
        permalink = nil
        thumbnail = nil
        acceptsMercadopago = nil
        installments = nil
        address = nil
        shipping = nil
        sellerAddress = nil
        attributes = nil
        categoryID = nil
        officialStoreID = nil
        catalogProductID = nil
        tags = nil
        catalogListing = nil
    }
}
