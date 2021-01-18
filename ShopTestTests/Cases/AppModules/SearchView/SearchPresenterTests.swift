//
//  SearchPresenterTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//

@testable import ShopTest
import XCTest

class SearchPresenterTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: SearchPresenter!
    var response: Search.LoadInitalData.Response!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupSearchPresenter()
        response = Search.LoadInitalData.Response(navBarTitle: NSLocalizedString("searchView.navigationBar.Title", comment: ""), placeholderSearchView: NSLocalizedString("searchView.searchBar.placeholder", comment: ""), initialMessage: NSLocalizedString("searchView.initialMessage", comment: ""))
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchPresenter(){
        sut = SearchPresenter()
    }
    
    // MARK: Test doubles
    
    class SearchDisplayLogicSpy: SearchDisplayLogic{
        var displayInitialInformationCalled = false
        var displaySearchResultsCalled = false
        var displayMoreItemsCalled = false
        var displayMessageErrorCalled = false
        
        
        func displayInitialInformation(viewModel: Search.LoadInitalData.ViewModel) {
            displayInitialInformationCalled = true
        }
        
        func displaySearchResults(viewModel: Search.SearchByTerm.ViewModel) {
            displaySearchResultsCalled = true
        }
        
        func displayMoreItems(viewModel: Search.GetMoreResults.ViewModel) {
            displayMoreItemsCalled = true
        }
        
        func displayMessageError(viewmodel: Search.ShowError.ViewModel) {
            displayMessageErrorCalled = true
        }
        
    }
    
    // MARK: Tests
    
    func testPresentSomething(){
        // Given
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy
        
        // When
        sut.presentInitialInformation(response: response)
        
        // Then
        XCTAssertTrue(spy.displayInitialInformationCalled, "presentInitialInformation(response:) should ask the view controller to display the result")
    }
}
