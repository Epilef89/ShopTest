//
//  NetworkManager.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

struct NetworkManager {
    static func requestBasicWithURLConvertible(uRLRequestConvertible: URLRequestConvertible,
                                               completion: @escaping(_ http: HTTPURLResponse, _ result: Result<Any>) -> Void) {

        let networkEngine = NetworkEngine()
        networkEngine.requestGeneric(request: uRLRequestConvertible.asURLRequest()) {(resultData, response, error) in
            if error != nil {
                completion(response ?? HTTPURLResponse.init(), Result<Any>.failure(error))
                return
            }

            guard let data = resultData else {
                completion(response ?? HTTPURLResponse.init(),
                           Result<Any>.failure(CustomErrors.errorGeneralResponse))
                return
            }
            
            apiDecodeController(data: data, uRLRequestConvertible: uRLRequestConvertible,
                          response: response ?? HTTPURLResponse.init(),
                          completion: { (resultData, response) in
                            completion(resultData, response)
            })
        }
    }
    
    static func apiDecodeController(data: Data,
                                    uRLRequestConvertible: URLRequestConvertible,
                                    response: HTTPURLResponse,
                                    completion: @escaping(HTTPURLResponse, Result<Any>) -> Void) {
        let api = uRLRequestConvertible as? APIRouter
        let decoder = JSONDecoder()
        
        switch api.self {
        case  .searchByTerms:
            guard let loginModelCodable = try? decoder.decode(SearchResults.self, from: data) else {
                completion(response,
                           Result<Any>.failure(CustomErrors.errorGeneralResponse))
                return
            }
            
            completion(response, Result<Any>.success(loginModelCodable))
            
        case .none:
            break
        }
    }
}
