//
//  Log.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import Foundation

public class Log{
    
    public var service:String?
    public var url:String?
    public var headers:String?
    public var body:String?
    public var headersResponse:String?
    public var bodyResponse:String?
    
    init(from request:URLRequest, service:String){
        
        self.service = service
        self.url = request.url?.absoluteString ?? ""
        self.body = String(data: request.httpBody ?? Data(), encoding: String.Encoding.utf8) as String?
        self.headers = request.allHTTPHeaderFields?.getKeyValueString()
        
    }
}
