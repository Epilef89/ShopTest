//
//  SearchWorkerTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//
//

@testable import ShopTest
import XCTest

class SearchWorkerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: SearchWorker!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupSearchWorker()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchWorker()
    {
        sut = SearchWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething()
    {
        // Given
        
        // When
        
        // Then
    }
}
