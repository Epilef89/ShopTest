//
//  LaunchScreenViewController.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.


import UIKit

protocol LaunchScreenDisplayLogic: class {
    func displayInitialInformation(viewModel: LaunchScreen.LoadInitalData.ViewModel)
}

class LaunchScreenViewController: BaseViewController, LaunchScreenDisplayLogic {
    var interactor: LaunchScreenBusinessLogic?
    var router: (NSObjectProtocol & LaunchScreenRoutingLogic & LaunchScreenDataPassing)?
    // MARK: Outlets
    
    // MARK: var-let
    
    // MARK: Actions button
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    init() {
        let className = NSStringFromClass(LaunchScreenViewController.self).split(separator: ".")
        if className.count > 1{
            super.init(nibName: "\(className[1])", bundle: nil)
            setup()
        }else{
            super.init()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = LaunchScreenInteractor()
        let presenter = LaunchScreenPresenter()
        let router = LaunchScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialInformation()
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        let request = LaunchScreen.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: LaunchScreen.LoadInitalData.ViewModel) {
        
    }
}
