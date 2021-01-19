//
//  APIMeli.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation
import UIKit

class APIMeli{
    
    static func searchBy(term:String,country:String,offset:Int, completion:@escaping(HTTPURLResponse,Result<SearchResults>)->Void){
        
        let request = APIRouter.searchByTerms(term:term, country:country, offset:String(offset)).asURLRequest()
        let log = Log(from: request, service:"Search by Term \(term)")
        URLSession.shared.dataTask(with:request) { data, response, error in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else{
                URLSession.shared.dataTask(with:request) { data, response, error in
                    
                    guard let data = data, error == nil, let response = response as? HTTPURLResponse else{
                        if let error = error{
                            log.bodyResponse = error.localizedDescription
                        }
                        completion( HTTPURLResponse(),  Result<SearchResults>.failure(CustomErrors.errorGeneralResponse) )
                        return
                    }
                    log.headersResponse = response.allHeaderFields.getKeyValueString()
                    log.bodyResponse = String(data: data , encoding: String.Encoding.utf8) as String?
                    #warning("Pendiente almacenar log")
                    let decoder = JSONDecoder()
                    guard   let serverResponse = try? decoder.decode(SearchResults.self, from: data) else{
                        completion( response,  Result<SearchResults>.failure(CustomErrors.errorGeneralResponse) )
                        return
                    }
                    completion( response, Result<SearchResults>.success(serverResponse))
                }.resume()
                return
            }
            log.headersResponse = response.allHeaderFields.getKeyValueString()
            log.bodyResponse = String(data: data , encoding: String.Encoding.utf8) as String?
            #warning("Pendiente almacenar log")
            let decoder = JSONDecoder()
            guard   let serverResponse = try? decoder.decode(SearchResults.self, from: data) else{
                completion( response,  Result<SearchResults>.failure(CustomErrors.errorGeneralResponse) )
                return
            }
            if serverResponse.results == nil{
                completion( response,  Result<SearchResults>.failure(CustomErrors.errorGeneralResponse) )
            }else{
                completion( response, Result<SearchResults>.success(serverResponse))
            }
        }.resume()
    }
}


