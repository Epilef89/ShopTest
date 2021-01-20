//
//  SearchInteractorTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//

@testable import ShopTest
import XCTest

class SearchInteractorTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: SearchInteractor!
    var spy:SearchPresentationLogicSpy!

    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupSearchInteractor()
        
    }
    
    override func tearDown(){
        sut = nil
        spy = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchInteractor(){
        sut = SearchInteractor()
        spy = SearchPresentationLogicSpy()
        sut.presenter = spy
    }
    
    
    // MARK: Test doubles
    
    class SearchPresentationLogicSpy: SearchPresentationLogic{
        var presentInitialInformationCalled = false
        var presentShowResultsCalled = false
        var presentMoreResultsCalled = false
        var presentErrorCalled = false
        var presentGoToDetailCalled = false
        
        func presentInitialInformation(response: Search.LoadInitalData.Response) {
            presentInitialInformationCalled = true
        }
        
        func presentShowResults(response: Search.SearchByTerm.Response) {
            presentShowResultsCalled = true
        }
        
        func presentMoreResults(response: Search.GetMoreResults.Response) {
            presentMoreResultsCalled = true
        }
        
        func presentError(response: Search.ShowError.Response) {
            presentErrorCalled = true
        }
        func presentGoToDetail(response:Search.GoToDetail.Response){
            presentGoToDetailCalled = true
        }
    }
    
    class SearchWorkerSpy:SearchWorker{
        var fetchResultsCalled = false
        var customError:NSError?
        override func fetchResultsBy(_ term: String, country: String, offset: Int, limit:Int, completionHandler: @escaping (HTTPURLResponse, Result<SearchResults>) -> Void) {
            fetchResultsCalled = true
            if customError == nil{
                completionHandler(HTTPURLResponse(), Result<SearchResults>.success(Seeds.items.searchResult!))
            }else{
                completionHandler(HTTPURLResponse(), Result<SearchResults>.failure(customError))
            }
            
        }
    }
    
    
    // MARK: Tests
    
    func testSearchInteractor_whenLoadInitialInformation(){
        // Given
        let request = Search.LoadInitalData.Request()
        
        // When
        sut.loadInitialInformation(request: request)
        
        // Then
        XCTAssertTrue(spy.presentInitialInformationCalled, "loadInitialInformation(request:) should ask the presenter to format the result")
    }
    
    func testSearchInteractor_WhenSearchByTerm_AskWorker(){
        //Given
        let request = Search.SearchByTerm.Request(term: "iPhone")
        let spyWorker = SearchWorkerSpy()
        sut.worker = spyWorker

        //When
        sut.searchByTerm(request: request)
        
        //Then
        XCTAssertTrue(spyWorker.fetchResultsCalled, "searchByTerm(request:) should ask the worker by fetch results")
    }
    
    func testSearchInteractor_WhenSearchByTerm_AskPresenter(){
        // Given
        let spyWorker = SearchWorkerSpy()
        sut.worker = spyWorker
        let searchPresentationLogicSpy = SearchPresentationLogicSpy()
        sut.presenter = searchPresentationLogicSpy
        
        //When
        let request = Search.SearchByTerm.Request(term: "iPhone")
        sut.searchByTerm(request: request)
        
        // Then
        XCTAssertTrue(searchPresentationLogicSpy.presentShowResultsCalled, "searchByTerm(request:) should ask the presenter to format results")
    }
    
    func testSearchInteractor_WhenSearchByTerm_AnErrorOccour_askPresenter(){
        //Given
        let spyWorker = SearchWorkerSpy()
        sut.worker = spyWorker
        let searchPresentationLogicSpy = SearchPresentationLogicSpy()
        sut.presenter = searchPresentationLogicSpy
        
        //When
        let request = Search.SearchByTerm.Request(term: "iPhone")
        spyWorker.customError = CustomErrors.errorGeneralResponse
        sut.searchByTerm(request: request)
        
        //Then
        XCTAssertTrue(searchPresentationLogicSpy.presentErrorCalled, "sut.searchByTerm(request:) when error occours should ask the presenter to format error")
        
        
        
    }
    
    func testSearchInteractor_WhenGetMoreItemsByPreviousTerm_AskWorker(){
        //Given
        let request = Search.GetMoreResults.Request(retry: false)
        let spyWorker = SearchWorkerSpy()
        sut.worker = spyWorker
        //When
        sut.getMoreItemsByPreviousTerm(request: request)
        
        //Then
        XCTAssertTrue(spyWorker.fetchResultsCalled , "getMoreItemsByPreviousTerm(request:) should ask the presenter to format the result")
        
    }
    
    func testSearchInteractor_WhenGetMoreItemsByPreviousTerm_AskPresenter(){
        //Given
        let request = Search.GetMoreResults.Request(retry: false)
        let spyWorker = SearchWorkerSpy()
        sut.worker = spyWorker
        let searchPresentationLogicSpy = SearchPresentationLogicSpy()
        sut.presenter = searchPresentationLogicSpy
        
        //When
        sut.getMoreItemsByPreviousTerm(request: request)
        
        //Then
        XCTAssertTrue(searchPresentationLogicSpy.presentMoreResultsCalled , "getMoreItemsByPreviousTerm(request:) should ask the presenter to format the result")
        
    }
    
    func testSearchInteractor_WhenAnErrorOccour_askPresenter(){
        //Given
        let request = Search.GetMoreResults.Request(retry: false)
        let spyWorker = SearchWorkerSpy()
        sut.worker = spyWorker
        let searchPresentationLogicSpy = SearchPresentationLogicSpy()
        sut.presenter = searchPresentationLogicSpy

    }
    
    
    

}
