//
//  DetailItemWorkerTests.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import ShopTest
import XCTest

class DetailItemWorkerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: DetailItemWorker!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupDetailItemWorker()
    }
    
    override func tearDown(){
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailItemWorker(){
        sut = DetailItemWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething(){
        // Given
        
        // When
        
        // Then
    }
}
