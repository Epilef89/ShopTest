//
//  SearchRouter.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.


import UIKit

@objc protocol SearchRoutingLogic {
    func routeToDetailItem()
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?
    
    // MARK: Routing
    
    func routeToDetailItem(){
        let destinationVC = DetailItemViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailItemView(source: dataStore!, destination: &destinationDS)
        navigateToDetailView(source: viewController ?? SearchViewController(), destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToDetailView(source:SearchViewController, destination: DetailItemViewController){
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToDetailItemView(source: SearchDataStore, destination: inout DetailItemDataStore){
        destination.resultSearch = source.resultSearch
    }
}

