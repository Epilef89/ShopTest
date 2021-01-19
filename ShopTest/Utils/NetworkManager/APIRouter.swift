//
//  APIRouter.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation
import UIKit

enum APIRouter: URLRequestConvertible {
    
    case searchByTerms(term:String, country:String, offset:String)
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case  .searchByTerms:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .searchByTerms(_ , let country, _):
            return URLK.searchByTerm.rawValue.replacingOccurrences(of: "$SITE_ID", with: country)
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .searchByTerms(let term, _, let offset):
            return ["q":term,"offset":offset,"limit":"40"]
        }
    }
    
    
    
    // MARK: - URLRequestConvertible
    func asURLRequest() -> URLRequest {

        var url: URL
        var urlRequest: URLRequest

        switch self{
        
        case .searchByTerms:
            // Get BaseURL
            url = returnUrl(api: self)
            // add path to URL Base
            url = url.appendingPathComponent(path)
            let urlAll =  url.absoluteString
            //Transform params to string
            let parameters =  self.parameters!.stringFromHttpParameters()
            // constructs URLs according to RFC 3986
            var urlComponents =  URLComponents(string: urlAll)
            // add query params
            urlComponents?.query  =  parameters.removingPercentEncoding
            let urlSearch = urlComponents?.url
            //build Request from urlSearch
            urlRequest = URLRequest(url: urlSearch!)
            // Set Method
            urlRequest.httpMethod = method.rawValue
            
            return urlRequest
        }
    }
}
