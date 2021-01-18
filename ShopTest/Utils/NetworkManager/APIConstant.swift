//
//  APIConstant.swift
//  ShopTest
//
//  Created by david cortes on 17/01/21.
//

import UIKit


enum URLK:String{
    
    //Mercado Libre
    case searchByTerm = "sites/$SITE_ID/search"


}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "accept"
    case acceptEncoding = "Accept-Encoding"
    
}

enum ContentType: String {
    case json = "application/json"
    case Bearer = "Bearer "
}


enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

/// A dictionary of parameters to apply to a `URLRequest`.
typealias Parameters = [String: Any]


public protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest
}

extension URLRequestConvertible {
    public var urlRequest: URLRequest? { return asURLRequest() }
}

extension URLRequest: URLRequestConvertible {
    public func asURLRequest() -> URLRequest { return self }
}


enum Result<Value> {
    case success(Value)
    case failure(Error?)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

func returnUrl(api: APIRouter) -> URL {
    switch api {
    case .searchByTerms:
        return Environment.getBaseURL
    }
}
