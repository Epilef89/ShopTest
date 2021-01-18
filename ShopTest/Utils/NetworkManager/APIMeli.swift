//
//  APIMeli.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation
import UIKit

class APIMeli{
    
    static func searchBy(term:String,country:String,offset:Int, completion:@escaping(HTTPURLResponse,Result<ResultSearch>)->Void){
        
        let request = APIRouter.searchByTerms(term:term, country:country, offset:String(offset)).asURLRequest()
        var requestLog = request
        let log = Log(from: requestLog, service:"Search by Term \(term)")
        URLSession.shared.dataTask(with:request) { data, response, error in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else{
                URLSession.shared.dataTask(with:request) { data, response, error in
                    
                    guard let data = data, error == nil, let response = response as? HTTPURLResponse else{
                        if let error = error{
                            log.bodyResponse = error.localizedDescription
                        }
                        completion( HTTPURLResponse(),  Result<ResultSearch>.failure(error) )
                        return
                    }
                    log.headersResponse = response.allHeaderFields.getKeyValueString()
                    log.bodyResponse = String(data: data , encoding: String.Encoding.utf8) as String?
                    #warning("Pendiente almacenar log")
                    let decoder = JSONDecoder()
                    guard   let serverResponse = try? decoder.decode(ResultSearch.self, from: data) else{
                        completion( response,  Result<ResultSearch>.failure(error) )
                        return
                    }
                    completion( response, Result<ResultSearch>.success(serverResponse))
                }.resume()
                return
            }
            log.headersResponse = response.allHeaderFields.getKeyValueString()
            log.bodyResponse = String(data: data , encoding: String.Encoding.utf8) as String?
            #warning("Pendiente almacenar log")
            let decoder = JSONDecoder()
            guard   let serverResponse = try? decoder.decode(ResultSearch.self, from: data) else{
                completion( response,  Result<ResultSearch>.failure(error) )
                return
            }
            completion( response, Result<ResultSearch>.success(serverResponse))
        }.resume()
    }
}
