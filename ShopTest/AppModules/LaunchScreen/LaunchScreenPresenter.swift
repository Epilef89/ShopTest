//
//  LaunchScreenPresenter.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.


import UIKit

protocol LaunchScreenPresentationLogic {
    func presentInitialInformation(response: LaunchScreen.LoadInitalData.Response)
}

class LaunchScreenPresenter: LaunchScreenPresentationLogic {
    weak var viewController: LaunchScreenDisplayLogic?
    
    func presentInitialInformation(response: LaunchScreen.LoadInitalData.Response) {
        let viewModel = LaunchScreen.LoadInitalData.ViewModel(nameAnimation: response.nameAnimation, type: response.type, nameApp: response.nameApp)
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
}

