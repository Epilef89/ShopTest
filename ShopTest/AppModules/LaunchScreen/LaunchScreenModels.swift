//
//  LaunchScreenModels.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.

import UIKit

enum LaunchScreen {
    // MARK: Use cases
    
    enum LoadInitalData {
        struct Request {
        }
        struct Response {
            var nameAnimation:String
            var type:String
            var nameApp:String
        }
        struct ViewModel {
            var nameAnimation:String
            var type:String
            var nameApp:String
        }
    }
}

