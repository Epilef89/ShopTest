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
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupSearchInteractor()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchInteractor(){
        sut = SearchInteractor()
    }
    
    // MARK: Test doubles
    
    class SearchPresentationLogicSpy: SearchPresentationLogic{
        var presentInitialInformationCalled = false
        var presentShowResultsCalled = false
        var presentMoreResultsCalled = false
        var presentErrorCalled = false
        
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
    }
    
    // MARK: Tests
    
    func testDoSomething(){
        // Given
        let spy = SearchPresentationLogicSpy()
        sut.presenter = spy
        let request = Search.LoadInitalData.Request()
        
        // When
        sut.loadInitialInformation(request: request)
        
        // Then
        XCTAssertTrue(spy.presentInitialInformationCalled, "loadInitialInformation(request:) should ask the presenter to format the result")
    }
}
