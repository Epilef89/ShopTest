//
//  LaunchScreenInteractor.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import UIKit

protocol LaunchScreenBusinessLogic {
    func loadInitialInformation(request: LaunchScreen.LoadInitalData.Request)
}

protocol LaunchScreenDataStore {
    //var name: String { get set }
}

class LaunchScreenInteractor: LaunchScreenBusinessLogic, LaunchScreenDataStore {
    var presenter: LaunchScreenPresentationLogic?
    var worker: LaunchScreenWorker?
    //var name: String = ""
    
    func loadInitialInformation(request: LaunchScreen.LoadInitalData.Request) {
        worker = LaunchScreenWorker()

        
        let response = LaunchScreen.LoadInitalData.Response()
        presenter?.presentInitialInformation(response: response)
    }
}

