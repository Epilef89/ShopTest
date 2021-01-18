//
//  LaunchScreenWorkerTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//

@testable import ShopTest
import XCTest

class LaunchScreenWorkerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: LaunchScreenWorker!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupLaunchScreenWorker()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLaunchScreenWorker(){
        sut = LaunchScreenWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething(){
        // Given
        
        // When
        
        // Then
    }
}
