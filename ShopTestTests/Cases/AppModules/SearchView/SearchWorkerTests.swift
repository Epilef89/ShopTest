//
//  SearchWorkerTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//
//

@testable import ShopTest
import XCTest

class SearchWorkerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: SearchWorker!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupSearchWorker()
    }
    
    override func tearDown(){
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchWorker(){
        sut = SearchWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSearchWorker_FetchResults_WhenSuccess(){
        //Given
        let term = "iphone"
        let country = "MCO"
        let offset = 0
        let limit = 40
        let exp = expectation(description: "Success")
        var statusCode:Int?
        var searchResult:Result<SearchResults>?
        //When
        sut.fetchResultsBy(term, country: country, offset: offset, limit: limit) { (response, result) in
            searchResult = result
            statusCode = response.statusCode
            exp.fulfill()
        }
        //Then
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(statusCode, 200, "the request or service is not rigth")
        XCTAssertTrue(searchResult!.isSuccess)
    }
    
    func testSearchWorker_FetchResults_WhenCountryDontExist(){
        let term = "iphone"
        let country = "M"
        let limit = 40
        let offset = 0
        let exp = expectation(description: "Success")
        var statusCode:Int?
        var customError:NSError?
        var searchResult:Result<SearchResults>?
        //When
        sut.fetchResultsBy(term, country: country, offset: offset, limit: limit) { (response, result) in
            searchResult = result
            statusCode = response.statusCode
            switch result{
            case .failure(let error):
                customError = error
                exp.fulfill()
            default:
                exp.fulfill()
            }
            
        }
        //Then
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(customError, "The response hasn't a error")
        XCTAssertTrue((customError == CustomErrors.errorGeneralResponse || customError == CustomErrors.errorNetworkConection ))
        XCTAssertNotEqual(statusCode, 200, "the request or service is not rigth")
        XCTAssertTrue(searchResult!.isFailure)
    }
    
    func testSearchWorker_FetchResults_WhenOutOfRange(){
        let term = "iPhone"
        let country = "MCO"
        let limit = 40
        let offset = 1010
        let exp = expectation(description: "Failure")
        var statusCode:Int?
        var customError:NSError?
        //When
        sut.fetchResultsBy(term, country: country, offset: offset, limit: limit) { (response, result) in
            statusCode = response.statusCode
            switch result{
            case .failure(let error):
                customError = error
                exp.fulfill()
            default:
                exp.fulfill()
            }
        }
        //Then
        wait(for: [exp], timeout: 5)
        XCTAssertNotEqual(statusCode, 200, "the request or service is not rigth")
        XCTAssertNotNil(customError, "The response hasn't a error")
        XCTAssertTrue(customError == CustomErrors.errorGeneralResponse || customError == CustomErrors.errorNetworkConection)
        
    }
    
    
    
}
