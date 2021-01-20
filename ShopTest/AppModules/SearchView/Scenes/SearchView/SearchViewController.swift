//
//  SearchViewController.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.


import UIKit

protocol SearchDisplayLogic: class {
    func displayInitialInformation(viewModel: Search.LoadInitalData.ViewModel)
    func displaySearchResults(viewModel:Search.SearchByTerm.ViewModel)
    func displayMoreItems(viewModel:Search.GetMoreResults.ViewModel)
    func displayMessageError(viewmodel:Search.ShowError.ViewModel)
    func displayGoToDetail(viewModel:Search.GoToDetail.ViewModel)
}

class SearchViewController: BaseViewController, SearchDisplayLogic {
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    // MARK: Outlets
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var initialMessageLabel: BigTitleLabel!
    @IBOutlet weak var searchContainerView: UIView!
    
    // MARK: var-let
    var searchController = UISearchController(searchResultsController: nil)
    var searchByTems:Search.SearchByTerm.ViewModel?
    // MARK: Actions button
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    init() {
        let className = NSStringFromClass(SearchViewController.self).split(separator: ".")
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
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.blueMainColor
        searchController.searchBar.barTintColor = UIColor.clear
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.backgroundColor = UIColor.clear
        searchController.searchBar.returnKeyType = .search
    }
    
    private func setUPTableView(){
        self.resultsTableView.delegate = self
        self.resultsTableView.dataSource = self
        self.resultsTableView.register(UINib(nibName: ReultTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ReultTableViewCell.identifier)
        
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialInformation()
        setSearchBar()
        setUPTableView()
        setEnableNavigationbar(type: .main)
        
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        let request = Search.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    func searchSuggestion(term:String){
        
    }
    
    func searchItemBy(_ term: String){
        if !(router?.dataStore?.wattingService ?? false) {
            let request = Search.SearchByTerm.Request(term: term)
            interactor?.searchByTerm(request: request)
            self.showLoader(show: true)
        }
        
    }
    
    func searchMoreItems(retry:Bool = false){
        if !(router?.dataStore?.wattingService ?? false) && (searchByTems?.moreResults ?? false){
            let request = Search.GetMoreResults.Request(retry: retry)
            interactor?.getMoreItemsByPreviousTerm(request: request)
            self.showLoader(show: true)
        }
        
    }
    
    func goToDetailItem(item:ResultSearch){
        let request = Search.GoToDetail.Request(resultSearch: item)
        interactor?.goToDetail(request: request)
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: Search.LoadInitalData.ViewModel) {
        self.navigationBar.isHidden = false
        self.backgroundNavigationBar.isHidden = false
        self.titleLabelNavigationBar.text = viewModel.navBarTitle
        self.initialMessageLabel.text = viewModel.initialMessage
        self.searchController.searchBar.placeholder = viewModel.placeholderSearchView

    }
    
    func displaySearchResults(viewModel:Search.SearchByTerm.ViewModel){
        self.searchByTems = viewModel
        self.resultsTableView.reloadData()
        self.resultsTableView.isHidden = false
        self.resultsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        self.showLoader(show: false)
    }
    
    func displayMoreItems(viewModel:Search.GetMoreResults.ViewModel){
        self.searchByTems?.resultSearch.append(contentsOf: viewModel.resultSearch)
        self.resultsTableView.reloadData()
        self.showLoader(show: false)
    }
    
    func displayMessageError(viewmodel:Search.ShowError.ViewModel){
        self.searchController.isActive = false
        DispatchQueue.main.async {
            
            self.showLoader(show: false)
        }
        
        if viewmodel.retry{
            self.showAlertInfo(mainText: viewmodel.errorMessage, primaryButtonTitle: viewmodel.titlePrimaryButton, secundaryButtonTitle: viewmodel.titleSecundaryButton) {
                self.searchMoreItems(retry: true)
            }
        }else{
            self.showAlertInfo(mainText: viewmodel.errorMessage)
        }
        
        
    }
    
    func displayGoToDetail(viewModel:Search.GoToDetail.ViewModel){
        self.searchController.isActive = false
        self.navigationBar.isHidden = false
        self.router?.routeToDetailItem()
    }
    
    // MARK: Functions
    
    func restoreCurrentDataSource(){
        self.searchByTems = nil
        resultsTableView.isHidden = true
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
            let animationHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
                self?.resultsTableView.reloadData()
            }

            let completionHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
                self?.resultsTableView.reloadData()
            }
            
        coordinator.animate(alongsideTransition: animationHandler, completion: completionHandler)
    }
}

extension SearchViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            if searchText.count > 2{
                searchSuggestion(term: searchText)
            }
        }
    }
    
    
}

extension SearchViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = true
        if let searchText = searchBar.text{
            searchItemBy(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = true
        restoreCurrentDataSource()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText == ""{
            restoreCurrentDataSource()
        }
    }
    

}

// MARK: TableView Delegate & Datasource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchByTems?.resultSearch.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let result = searchByTems?.resultSearch[indexPath.row] else{
            return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: ReultTableViewCell.identifier, for: indexPath) as! ReultTableViewCell
        cell.setWith(result: result)
        cell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let searchItems = searchByTems?.resultSearch else{return}
        
        if searchItems.count > 0{
            if indexPath.row == searchItems.count - 1{
                self.searchMoreItems()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = searchByTems?.resultSearch[indexPath.row] else{
            return
        }
        self.goToDetailItem(item: item)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchByTems?.totalResultsCount
    }
    
    
}


