//
//  DetailItemRouter.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

@objc protocol DetailItemRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DetailItemDataPassing {
    var dataStore: DetailItemDataStore? { get }
}

class DetailItemRouter: NSObject, DetailItemRoutingLogic, DetailItemDataPassing {
    weak var viewController: DetailItemViewController?
    var dataStore: DetailItemDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier:
    //"SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source:
    //DetailItemViewController, destination:
    //SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: DetailItemDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

