//
//  SearchWorker.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.


import UIKit

class SearchWorker {
    
    func fetchResultsBy(_ term:String, country:String,offset:Int,limit:Int, completionHandler: @escaping (HTTPURLResponse, Result<SearchResults>) -> Void) {
    NetworkManager.requestBasicWithURLConvertible(uRLRequestConvertible:
                                                    APIRouter.searchByTerms(term: term, country:country, offset: String(offset), limit: limit)) { (response, result) in
        
        switch result {
        case .success(let rearchResults):
            guard let searchReponse = rearchResults as? SearchResults else {
                completionHandler(response, Result<SearchResults>.failure(CustomErrors.errorGeneralResponse))
                return
            }
            completionHandler(response,
                              Result<SearchResults>.success(searchReponse))
        case .failure(let error):
             completionHandler(response, Result<SearchResults>.failure(error))
        }
    }}
}
