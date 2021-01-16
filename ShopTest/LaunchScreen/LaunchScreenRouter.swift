//
//  LaunchScreenRouter.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.


import UIKit

@objc protocol LaunchScreenRoutingLogic {
    
}

protocol LaunchScreenDataPassing {
    var dataStore: LaunchScreenDataStore? { get }
}

class LaunchScreenRouter: NSObject, LaunchScreenRoutingLogic, LaunchScreenDataPassing {
    weak var viewController: LaunchScreenViewController?
    var dataStore: LaunchScreenDataStore?
    
    // MARK: Routing
    
    
    // MARK: Navigation
    

}

