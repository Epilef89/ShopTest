//
//  DetailItemViewController.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol DetailItemDisplayLogic: class {
    func displayInitialInformation(viewModel: DetailItem.LoadInitalData.ViewModel)
}

class DetailItemViewController: BaseViewController, DetailItemDisplayLogic {
    var interactor: DetailItemBusinessLogic?
    var router: (NSObjectProtocol & DetailItemRoutingLogic & DetailItemDataPassing)?
    // MARK: Outlets
    @IBOutlet weak var detailTableView: UITableView!
    
    // MARK: var-let
    var resultSearch:ResultSearch?
    var detail:[DetailDescription] = []
    
    // MARK: Actions button
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    init() {
        let className = NSStringFromClass(DetailItemViewController.self).split(separator: ".")
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
        let interactor = DetailItemInteractor()
        let presenter = DetailItemPresenter()
        let router = DetailItemRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setUPTableView(){
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        self.detailTableView.register(UINib(nibName: ImageDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ImageDetailTableViewCell.identifier)
        self.detailTableView.register(UINib(nibName: DetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.identifier)
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
        setUPTableView()
        loadInitialInformation()
        self.setEnableNavigationbar(type: .back)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailTableView.estimatedRowHeight = 50
        detailTableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        let request = DetailItem.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: DetailItem.LoadInitalData.ViewModel) {
        self.resultSearch = viewModel.resultSearch
        self.detail = viewModel.detail
        self.titleLabelNavigationBar.text = viewModel.titleView
        self.detailTableView.reloadData()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
            let animationHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
                self?.detailTableView.reloadData()
            }

            let completionHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
                self?.detailTableView.reloadData()
            }
            
        coordinator.animate(alongsideTransition: animationHandler, completion: completionHandler)
    }
}

//MARK: TableView Delegate And Datasource

extension DetailItemViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageDetailTableViewCell.identifier, for: indexPath) as! ImageDetailTableViewCell
            if resultSearch != nil{
                cell.setWith(result: resultSearch!)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
            if detail.count > 0{
                cell.setWith(detail: detail[indexPath.row - 1])
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return (self.view.frame.height / 3 >= self.view.frame.width / 3 ? self.view.frame.height / 3 : self.view.frame.width / 3)
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    
    
}

