//
//  GeoLocationManagerTest.swift
//  ShopTestTests
//
//  Created by david cortes on 16/01/21.
//

import XCTest
@testable import ShopTest

class GeoLocationManagerTest: XCTestCase {

    var sut:GeoLocationManager!
    
    override func setUp() {
        super.setUp()
        sut = GeoLocationManager()
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGeoLocationManager_RequestPermission(){
        //Given
        
        //When
        sut.requestPermission()
    }
}
