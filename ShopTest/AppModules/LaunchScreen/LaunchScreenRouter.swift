//
//  LaunchScreenRouter.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.


import UIKit

@objc protocol LaunchScreenRoutingLogic {
    func routeToSearchView()
}

protocol LaunchScreenDataPassing {
    var dataStore: LaunchScreenDataStore? { get }
}

class LaunchScreenRouter: NSObject, LaunchScreenRoutingLogic, LaunchScreenDataPassing {
    weak var viewController: LaunchScreenViewController?
    var dataStore: LaunchScreenDataStore?
    
    // MARK: Routing
    func routeToSearchView() {
        let destinationVC = SearchViewController()
        navigateToSearchView(source: viewController ?? LaunchScreenViewController(), destination: destinationVC)
    }
    
    // MARK: Navigation
    private func navigateToSearchView(source:LaunchScreenViewController, destination:SearchViewController){
        let navigation = UINavigationController(rootViewController: destination)
        navigation.modalPresentationStyle = .currentContext
        source.show(navigation, sender: nil)
    }

}

