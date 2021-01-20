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
    var spy: SearchDisplayLogicSpy!
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupSearchPresenter()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchPresenter(){
        sut = SearchPresenter()
        spy = SearchDisplayLogicSpy()
        sut.viewController = spy
    }
    
    //MARK: Given
    
    func getSearchResults()->[ResultSearch]{
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "items", ofType: "json")
        let data =  try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        let decoder = JSONDecoder()
        guard let searchResultsCodable = try? decoder.decode(SearchResults.self, from: data) else {
            return [] as [ResultSearch]
        }
        return searchResultsCodable.results ?? []
    }
    
    // MARK: Test doubles
    
    class SearchDisplayLogicSpy: SearchDisplayLogic{
        var displayInitialInformationCalled = false
        var displaySearchResultsCalled = false
        var displayMoreItemsCalled = false
        var displayMessageErrorCalled = false
        var totalResultsTitle = ""
        var displayGoToDetailCalled = false
        
        func displayInitialInformation(viewModel: Search.LoadInitalData.ViewModel) {
            
            displayInitialInformationCalled = true
        }
        
        func displaySearchResults(viewModel: Search.SearchByTerm.ViewModel) {
            totalResultsTitle = viewModel.totalResultsCount
            displaySearchResultsCalled = true
        }
        
        func displayMoreItems(viewModel: Search.GetMoreResults.ViewModel) {
            displayMoreItemsCalled = true
        }
        
        func displayMessageError(viewmodel: Search.ShowError.ViewModel) {
            displayMessageErrorCalled = true
        }
        func displayGoToDetail(viewModel:Search.GoToDetail.ViewModel){
            displayGoToDetailCalled = true
        }
        
    }
    
    // MARK: Tests
    
    func testSearchPresenter_WhenPresentInitialInformation(){
        // Given
        let LoadInitialDataresponse =  Search.LoadInitalData.Response()
        
        // When
        sut.presentInitialInformation(response: LoadInitialDataresponse)
        
        // Then
        
        XCTAssertTrue(spy.displayInitialInformationCalled, "presentInitialInformation(response:) should ask the view controller to display the initialData")
    }
    
    func testSearchPresenter_WhenPresentSearchResults(){
        //Given
        let results = getSearchResults()
        let searchByTermResponse = Search.SearchByTerm.Response(resultSearch: results, totalResultsCount: results.count, term: "", moreResults: true)
        
        //When
        sut.presentShowResults(response: searchByTermResponse)
        let totlaResultsCount = NSLocalizedString("searchView.quantityResultsMessage", comment: "")
            .replacingOccurrences(of: "$0", with: String(searchByTermResponse.resultSearch.count))
            .replacingOccurrences(of: "$1", with: searchByTermResponse.term)
        //Then
        XCTAssertTrue(spy.displaySearchResultsCalled, "presentShowResults(response:) should ask the view controller to display the resultsByTerm")
        XCTAssertEqual(spy.totalResultsTitle, totlaResultsCount)
    }
    
    func testSearchPresenter_WhenPresentMoreItems(){
        //Given
        let moreResultsResponse = Search.GetMoreResults.Response(resultSearch: [], totalResultsCount: 0, moreResults: true)
        
        //When
        sut.presentMoreResults(response: moreResultsResponse)
        
        //Then
        XCTAssertTrue(spy.displayMoreItemsCalled, "presentMoreResults(response:) should ask the view controller to display more Items")
    }
    
    func testSearchPresenter_WhenPresentMessageError(){
        //Given
        let showErrorResponse = Search.ShowError.Response(errorMessage: CustomErrors.errorGeneralResponse, retry: false)
        
        //When
        sut.presentError(response: showErrorResponse)
        
        //Then
        XCTAssert(spy.displayMessageErrorCalled, "presentError(response:) should ask the view controller to display message error")
        
    }
}
