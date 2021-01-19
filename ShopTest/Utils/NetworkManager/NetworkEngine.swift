//
//  NetworkEngine.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation



class NetworkEngine {
    func requestGeneric(request: URLRequest, completion: @escaping(Data?, HTTPURLResponse?, NSError?) -> Void) {
        veriedInternetConection {(data, response, error) in
            
            if error == nil{
                self.printerNetworkDebugRequest(request: request)
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let response = response as? HTTPURLResponse else {
                        DispatchQueue.main.async {
                            completion(nil, nil, CustomErrors.errorGeneralResponse)
                        }
                        
                        return
                    }
                    
                    self.printerNetworkDebugResponse(response: response,
                                                     data: data ?? Data(),
                                                     error: error ?? NSError(domain: "", code: 0, userInfo: nil))
                    
                    guard let resultData = data else {
                        DispatchQueue.main.async {
                            completion(nil, nil, CustomErrors.errorGeneralResponse)
                        }
                        
                        return
                    }
                    
                    self.manageHttpCodeResponse(response: response, realData: resultData, error: error, request: request, completion: { (data, response, error) in
                        completion(data, response, error)
                    })
                }.resume()
            }else{
                completion(data, response, error)
            }
            
        }
        
        
    }
    
    func veriedInternetConection(completion: @escaping(Data?, HTTPURLResponse?, NSError?) -> Void) {
        let reachabilityManager = ReachabilityManager()
        if reachabilityManager.checkReachable() == .unreachable{
            completion(nil, nil, CustomErrors.errorNetworkConection)
        }else{
            completion(nil, nil, nil)
        }
    }
    
    func manageHttpCodeResponse(response: HTTPURLResponse,
                                realData: Data,
                                error: Error?,
                                request:URLRequest,
                                completion: @escaping(Data?, HTTPURLResponse?, NSError?) -> Void) {
        switch response.statusCode {
        case 200:
            DispatchQueue.main.async {
                completion(realData, response, nil)
            }
        default:
            DispatchQueue.main.async {
                completion(realData, response, CustomErrors.errorGeneralResponse)
            }
        }
    }

    
    func printerNetworkDebugRequest(request: URLRequest) {
        PrintCustom.printDebug(toPrint: "**********REQUEST**********")
        PrintCustom.printDebug(toPrint: "*****Request URL: \(request)")
        PrintCustom.printDebug(toPrint: "*****Request HeaderFields: \(String(describing: request.allHTTPHeaderFields))")
        let stringPrintData = String(NSString(data: request.httpBody ?? Data(),
                                              encoding: String.Encoding.utf8.rawValue) ?? "")
        PrintCustom.printDebug(toPrint: "*****Request Body: \(stringPrintData)")

        PrintCustom.printDebug(toPrint: String(NSString(data: request.httpBody ?? Data() ,
                                                        encoding: String.Encoding.utf8.rawValue) ?? ""))
        
    }
    
    func printerNetworkDebugResponse(response: HTTPURLResponse, data: Data, error: Error) {
        PrintCustom.printDebug(toPrint: "*****Response*****")
        PrintCustom.printDebug(toPrint: "*****Response http: \(response)")
        PrintCustom.printDebug(toPrint: "*****Response error: \(String(describing: error))")
        PrintCustom.printDebug(toPrint: "*****Response Body: \(String(NSString(data: data ,encoding: String.Encoding.utf8.rawValue) ?? ""))")

    }
    
    
}

