//
//  SearchViewControllerTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//

@testable import ShopTest
import XCTest

class SearchViewControllerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: SearchViewControllerSpy!
    var window: UIWindow!
    var viewModel: Search.LoadInitalData.ViewModel!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        window = UIWindow()
        setupSearchViewController()
        viewModel = Search.LoadInitalData.ViewModel(navBarTitle: NSLocalizedString("searchView.navigationBar.Title", comment: ""), placeholderSearchView: NSLocalizedString("searchView.searchBar.placeholder", comment: ""), initialMessage: NSLocalizedString("searchView.initialMessage", comment: ""))
    }
    
    override func tearDown(){
        window = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchViewController(){
        sut = SearchViewControllerSpy()
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Given
    func givenInitialViewModelMock()->Search.SearchByTerm.ViewModel{
        
        let searchResultsCodable = getSearchResults()
        return Search.SearchByTerm.ViewModel(resultSearch: searchResultsCodable?.results ?? [], totalResultsCount: String(searchResultsCodable?.results?.count ?? 0), moreResults: true)
        
    }
    
    func givenMoreResultsViewModelMock()->Search.GetMoreResults.ViewModel{
        let searchResultsCodable = getSearchResults()
        return Search.GetMoreResults.ViewModel(resultSearch: searchResultsCodable?.results ?? [], totalResultsCount: String(searchResultsCodable?.results?.count ?? 0), moreResults: true)
    }
    
    func givenErrorGeneralResponseViewModel()->Search.ShowError.ViewModel{
        
        return Search.ShowError.ViewModel(errorMessage: CustomErrors.errorGeneralResponse.getErrorMessage() , retry: true, titlePrimaryButton: NSLocalizedString("", comment: ""), titleSecundaryButton: NSLocalizedString("", comment: ""))
    }
    
    func givenErrorNetworkConectionViewModel()->Search.ShowError.ViewModel{
        
        return Search.ShowError.ViewModel(errorMessage: CustomErrors.errorNetworkConection.getErrorMessage() , retry: false, titlePrimaryButton: NSLocalizedString("", comment: ""), titleSecundaryButton: NSLocalizedString("", comment: ""))
    }
    
    func givenErrorNoDataViewModel()->Search.ShowError.ViewModel{
        
        return Search.ShowError.ViewModel(errorMessage: CustomErrors.errorNoData.getErrorMessage() , retry: false, titlePrimaryButton: NSLocalizedString("", comment: ""), titleSecundaryButton: NSLocalizedString("", comment: ""))
    }
    
    func givenErrorOutOfRangeViewModel()->Search.ShowError.ViewModel{
        
        return Search.ShowError.ViewModel(errorMessage: CustomErrors.errorOffsetOutOffRange.getErrorMessage() , retry: false, titlePrimaryButton: NSLocalizedString("", comment: ""), titleSecundaryButton: NSLocalizedString("", comment: ""))
    }
    
    func getSearchResults()->SearchResults?{
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "items", ofType: "json")
        let data =  try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        let decoder = JSONDecoder()
        guard let searchResultsCodable = try? decoder.decode(SearchResults.self, from: data) else {
            return nil
        }
        return searchResultsCodable
    }
    
    // MARK: Test doubles
    
    class SearchBusinessLogicSpy: SearchBusinessLogic{
        var loadInitialInformationCalled = false
        var searchByTermCalled = false
        var getMoreItemsByPreviousTermCalled = false
        var goToDetailCalled = false
        
        func loadInitialInformation(request: Search.LoadInitalData.Request){
            loadInitialInformationCalled = true
        }
        
        func searchByTerm(request: Search.SearchByTerm.Request) {
            searchByTermCalled = true
        }
        
        func getMoreItemsByPreviousTerm(request: Search.GetMoreResults.Request) {
            getMoreItemsByPreviousTermCalled = true
        }
        
        func goToDetail(request:Search.GoToDetail.Request){
            goToDetailCalled = true
        }
    }
    
    class SearchViewControllerSpy:SearchViewController{
        var showAlertInfoIsCalled = false
        override func showAlertInfo(mainText: String, titleButton: String = NSLocalizedString("aceptButton", comment: ""), action: @escaping () -> Void = {}) {
            showAlertInfoIsCalled = true
        }
        
        override func showAlertInfo(mainText: String, primaryButtonTitle: String = NSLocalizedString("aceptButton", comment: ""), primaryButtonAction: @escaping () -> Void = {}, secundaryButtonTitle: String, secundaryButtonAction: @escaping () -> Void) {
            showAlertInfoIsCalled = true
        }
    }
    
    
    // MARK: Tests
    
    func testSearchViewController_ShouldLoadInitialInformation_WhenViewIsLoaded(){
        // Given
        let spy = SearchBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.loadInitialInformationCalled, "viewDidLoad() should ask the interactor to loadInitialInformation")
    }
    
    func testSearchViewController_ShouldShowInitialInformation_WhenViewIsLoaded(){
        // Given
        
        // When
        loadView()
        sut.displayInitialInformation(viewModel:viewModel)
        
        // Then
        let navigationBarSubviews = sut.navigationBar.subviews
        let navView = navigationBarSubviews.filter({$0.isKind(of: NavigationBarTitleLabel.self)}).first as! NavigationBarTitleLabel
        let messageView = sut.initialMessageLabel
        let searchBarPlaceholder = sut.searchController.searchBar.placeholder
        
        XCTAssertEqual(navView.text, NSLocalizedString("searchView.navigationBar.Title", comment: ""), "displayInitialInformation(viewModel:) should update the navigation bar title")
        XCTAssertEqual(messageView?.text, NSLocalizedString("searchView.initialMessage", comment: ""), "displayInitialInformation(viewModel:) should update the initial Message")
        XCTAssertEqual(searchBarPlaceholder, NSLocalizedString("searchView.searchBar.placeholder", comment: ""),"displayInitialInformation(viewModel:) should update the placeholder in searchController" )
    }
    
    func testSearchViewController_ShoudCallToSearchByTerm_whenEnterSearchTerm(){
        //Given
        let spy = SearchBusinessLogicSpy()
        sut.interactor = spy
        
        //When
        loadView()
        sut.displayInitialInformation(viewModel: viewModel)
        sut.searchController.searchBar.text = "Ipohne"
        
        //Then
        sut.searchBarSearchButtonClicked(sut.searchController.searchBar)
        XCTAssertTrue(spy.searchByTermCalled,"enter a search term Should ask the interactor to searchByTerm")
    }
    
    func testSearchViewController_ShouldShowResults_WhenGetResults(){
        //Given
        let viewModel = givenInitialViewModelMock()
        
        //When
        loadView()
        sut.displaySearchResults(viewModel: viewModel)
        
        //Then
        XCTAssertNotNil(sut.searchByTems)
        XCTAssertTrue(sut.resultsTableView.dataSource?.tableView(sut.resultsTableView, numberOfRowsInSection: 1) == viewModel.resultSearch.count)
        
    }
    
    func testSearchViewController_ShouldCallToGetMoreItemsByPreviousTerm(){
        //Given
        let spy = SearchBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        let viewModel = givenInitialViewModelMock()
        sut.displaySearchResults(viewModel: viewModel)
        let cell = ReultTableViewCell()
        
        //When
        sut.resultsTableView.delegate?.tableView?(sut.resultsTableView, willDisplay: cell, forRowAt: IndexPath(row: viewModel.resultSearch.count - 1, section: 1))
        
        //Then
        XCTAssertTrue(spy.getMoreItemsByPreviousTermCalled, "When will display last cell from tableView Should call to get MoreItemsByPreviousTerm(request:")
    }
    
    func testSearchViewController_ShouldShowMoreResults_WhenGetMoreResults(){
        //Given
        loadView()
        let resultsViewModel = givenInitialViewModelMock()
        let moreResultsViewModel = givenMoreResultsViewModelMock()
        
        //When
        sut.displaySearchResults(viewModel: resultsViewModel)
        sut.displayMoreItems(viewModel: moreResultsViewModel)
        let totalResults = (resultsViewModel.resultSearch.count + moreResultsViewModel.resultSearch.count)
        let rowsInTableView = sut.resultsTableView.dataSource?.tableView(sut.resultsTableView, numberOfRowsInSection: 1)
        
        //Then
        XCTAssertTrue(sut.searchByTems?.resultSearch.count == totalResults , "When more results are added, the total of results must be equal to the amount of results received")
        XCTAssertTrue(sut.searchByTems?.resultSearch.count == rowsInTableView, "When more results are added, the total of rows in the tableView must be equal to the amount of results received" )
    }
    
    func testSearchViewController_EmptyResults_WhensearchBarCancelButtonClicked(){
        //Given
        loadView()
        let viewModel = givenInitialViewModelMock()
        sut.displaySearchResults(viewModel: viewModel)
        
        //When
        sut.searchBarCancelButtonClicked(sut.searchController.searchBar)
        
        //Then
        XCTAssertNil(sut.searchByTems, "When cancel button in the searchView is tapped all results should be nil")
        XCTAssertTrue(sut.resultsTableView.isHidden, "When cancel button in the searchView is tapped resultsTableView should be hidden")
    }
    
    func testSearchViewController_EmptyResults_WhenSearchBarTextIsEmpty(){
        //Given
        loadView()
        let viewModel = givenInitialViewModelMock()
        sut.displaySearchResults(viewModel: viewModel)
        
        //When
        sut.searchBar(sut.searchController.searchBar, textDidChange: "")
        
        //Then
        XCTAssertNil(sut.searchByTems, "When text in the searchView is \"\" all results should be nil")
        XCTAssertTrue(sut.resultsTableView.isHidden, "When text in the searchView is \"\" resultsTableView should be hidden")
    }
    
    func testSearchViewController_ShowAlertView_WhenErrorGeneralResponseOccurred(){
        //Given
        loadView()
        let errorViewModel = givenErrorGeneralResponseViewModel()
        
        //When
        sut.displayMessageError(viewmodel: errorViewModel)
        
        //Then
        XCTAssertTrue(sut.showAlertInfoIsCalled)
        
    }
    
    func testSearchViewController_ShowAlertView_WhenErrorNoDataViewModel(){
        //Given
        loadView()
        let errorViewModel = givenErrorNoDataViewModel()
        
        //When
        sut.displayMessageError(viewmodel: errorViewModel)
        
        //Then
        XCTAssertTrue(sut.showAlertInfoIsCalled)
        
    }
    
    func test_TableViewCell_WithResult(){
        //Given
        loadView()
        let viewModelResults = givenInitialViewModelMock()
        
        
        
        //When
        sut.displaySearchResults(viewModel: viewModelResults)
        guard let cell = sut.resultsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ReultTableViewCell else{XCTFail("Invalid Cell"); return}
        let productName = cell.nameProductLabel.text
        let price = cell.productCostLabel.text
        let condition = cell.productConditionLabel.text
        
        //Then
        XCTAssertEqual(productName, viewModelResults.resultSearch.first?.title ?? "", "Product name from cell shoud be equal to result from ViewModel")
        XCTAssertEqual(price, viewModelResults.resultSearch.first?.priceDisplaypriceDisplay ?? "", "Price item from cell shoud be equal to result from ViewModel")
        XCTAssertEqual(condition, viewModelResults.resultSearch.first?.conditionDisplay ?? "", "Condition item from cell shoud be equal to result from ViewModel")
        
    }
    
}
