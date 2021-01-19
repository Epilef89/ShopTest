//
//  Seeds.swift
//  ShopTestTests
//
//  Created by david cortes on 19/01/21.
//

import Foundation
@testable import ShopTest

struct Seeds {
    class Bar {}
    struct items {
        
        static var searchResult:SearchResults?{
            return getSearchResults()
        }
        
        static var resulstSearch:[ResultSearch]{
            return getSearchResults()?.results ?? []
        }
        
        private static func getSearchResults()->SearchResults?{
            let testBundle = Bundle(for: Seeds.Bar.self)
            let path = testBundle.path(forResource: "items", ofType: "json")
            let data =  try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
            let decoder = JSONDecoder()
            guard let searchResultsCodable = try? decoder.decode(SearchResults.self, from: data) else {
                return nil
            }
            return searchResultsCodable
        }
 
        
    }
}
