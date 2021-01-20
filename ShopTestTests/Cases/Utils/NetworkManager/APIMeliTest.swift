//
//  APIMeliTest.swift
//  ShopTestTests
//
//  Created by david cortes on 19/01/21.
//

import XCTest
@testable import ShopTest

class APIMeliTest: XCTestCase {

    // MARK: Subject under test
    var sut:APIMeli?
    var sutMock:APIMeli.Type = APIMeli.self
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = APIMeli()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    //MARK: Test Doubles
    
    // MARK: Tests
    func testAPIMeli_SearchByTerm_WhenSuccess(){
        //Given
        let term = "iphone"
        let country = "MCO"
        let offset = 0
        let limit = 40
        let exp = expectation(description: "Success")
        var statusCode:Int?
        
        
        //When
        sutMock.searchBy(term: term, country: country, offset: offset, limit: limit) { (response, result) in
            statusCode = response.statusCode
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(statusCode, 200, "the request or service is not rigth")
    }
    
    func testAPIMeli_SearchByTerm_WhenFailure(){
        //Given
        let term = "iphone"
        let country = "M"
        let offset = 0
        let limit = 40
        let exp = expectation(description: "Failure")
        var statusCode:Int?
        var customError:NSError?
        var searchResultt:Result<SearchResults>?
        //When
        sutMock.searchBy(term: term, country: country, offset: offset, limit: limit) { (response, result) in
            statusCode = response.statusCode
            searchResultt = result
            switch result{
            case .failure(let error):
                customError = error
                exp.fulfill()
            case .success(let results):
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(customError, "The response hasn't a error")
        XCTAssertTrue((customError == CustomErrors.errorGeneralResponse || customError == CustomErrors.errorNetworkConection ))
        XCTAssertNotEqual(statusCode, 200, "the request or service is not rigth")
        XCTAssertTrue(searchResultt!.isFailure)
    }

}


