//
//  LaunchScreenViewController.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.


import UIKit
import Lottie

protocol LaunchScreenDisplayLogic: class {
    func displayInitialInformation(viewModel: LaunchScreen.LoadInitalData.ViewModel)
}

class LaunchScreenViewController: BaseViewController, LaunchScreenDisplayLogic {
    var interactor: LaunchScreenBusinessLogic?
    var router: (NSObjectProtocol & LaunchScreenRoutingLogic & LaunchScreenDataPassing)?
    // MARK: Outlets
    
    // MARK: var-let
    var myAnimationView:AnimationView!
    var nameAppLabel:BigTitleLabel!
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
        guard let animationFilePath = Bundle.main.path(forResource: viewModel.nameAnimation , ofType: viewModel.type) else{return}
        
        myAnimationView = AnimationView(filePath: animationFilePath)
        myAnimationView.contentMode = .scaleAspectFit
        myAnimationView.loopMode = .loop
        myAnimationView.animationSpeed = 1.5
        view.addSubview(myAnimationView)
        myAnimationView.play()
        myAnimationView.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: myAnimationView!,
                                                attribute: NSLayoutConstraint.Attribute.centerX,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: view, attribute: NSLayoutConstraint.Attribute.centerX,
                                                multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: myAnimationView!,
                                                   attribute: NSLayoutConstraint.Attribute.centerY,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view,
                                                 attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1,
                                                 constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: myAnimationView!,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: view,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  multiplier: 0.5, constant: 1)
        let widthConstraint = NSLayoutConstraint(item: myAnimationView!,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 multiplier: 0.6, constant: 1)
        view.addConstraints([centerXConstraint, centerYConstraint, heightConstraint, widthConstraint])
        
        nameAppLabel = BigTitleLabel()
        nameAppLabel.text = viewModel.nameApp
        view.addSubview(nameAppLabel)
        nameAppLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerXLabelConstraint = NSLayoutConstraint(item: nameAppLabel!,
                                                attribute: NSLayoutConstraint.Attribute.centerX,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: view, attribute: NSLayoutConstraint.Attribute.centerX,
                                                multiplier: 1, constant: 0)
        let centerYLabelConstraint = NSLayoutConstraint(item: nameAppLabel!,
                                                        attribute: NSLayoutConstraint.Attribute.centerY,
                                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: myAnimationView,
                                                 attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1,
                                                 constant: 110)
        
        view.addConstraints([centerXLabelConstraint, centerYLabelConstraint])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("Nav to next View")
        }
    }
}
