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
    
    var sut: SearchViewController!
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
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchViewController(){
        sut = SearchViewController()
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class SearchBusinessLogicSpy: SearchBusinessLogic{
        var loadInitialInformationCalled = false
        var searchByTermCalled = false
        var getMoreItemsByPreviousTermCalled = false
        
        func loadInitialInformation(request: Search.LoadInitalData.Request){
            loadInitialInformationCalled = true
        }
        
        func searchByTerm(request: Search.SearchByTerm.Request) {
            searchByTermCalled = true
        }
        
        func getMoreItemsByPreviousTerm(request: Search.GetMoreResults.Request) {
            getMoreItemsByPreviousTermCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldDoSomethingWhenViewIsLoaded(){
        // Given
        let spy = SearchBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.loadInitialInformationCalled, "viewDidLoad() should ask the interactor to do loadInitialInformation")
    }
    
    func testDisplaySomething(){
        // Given
        
        // When
        loadView()
        sut.displayInitialInformation(viewModel:viewModel)
        
        // Then
        //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
    }
}
