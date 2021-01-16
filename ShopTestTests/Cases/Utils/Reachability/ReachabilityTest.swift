//
//  ReachabilityTest.swift
//  ShopTestTests
//
//  Created by david cortes on 16/01/21.
//

import XCTest
@testable import ShopTest

class ReachabilityTest: XCTestCase {

    var sut:ReachabilityManager!
    
    override func setUp() {
        super.setUp()
        sut = ReachabilityManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testReachability_checkRechable(){
        //Given
        
        //When
        let reachabilityStatus = sut.checkReachable()
        
        //Then
        XCTAssertTrue(reachabilityStatus == true, "Check internet connection!")
        
    }

}
