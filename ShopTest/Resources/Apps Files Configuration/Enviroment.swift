//
//  Enviroment.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import Foundation

///Enum to manage the values ​​of the environment configuration file
public enum Environment {
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    //get firebase plist name
    static let getGoogleFirebaseFile: String = {
        guard let rootURLstring = Environment.infoDictionary["googleFireBaseFile"] as? String else {
            fatalError("GoogleFirebaseFile not set in plist for this environment")
        }

        return rootURLstring
    }()
    
    //Get url base
    static let getBaseURL: URL = {
        guard let baseString = Environment.infoDictionary["baseURL"] as? String else {
            fatalError("baseURL not set in plist for this environment")
        }

        guard let baseUrl = URL(string: baseString) else {
            fatalError("baseURL is not a valid URL, verified in xccconfig")
        }

        return baseUrl
    }()

}
