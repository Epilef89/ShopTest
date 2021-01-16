//
//  KeychainWrapperTest.swift
//  ShopTestTests
//
//  Created by david cortes on 16/01/21.
//

import XCTest
@testable import ShopTest
import SwiftKeychainWrapper

class KeychainWrapperTest: XCTestCase {

    var sut:KeyManager!
    
    override func setUp() {
        super.setUp()
        sut = KeyManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testKeychainWrapper_setCountry(){
        //Given

        let country:String = "MCO"
        
        //When
        sut.set(country:country)
        
        //Then
        XCTAssertEqual(country, sut.getCountry(), "country Should be Equal to .getCountry()")
        
    }
    
    func testKeychainWrapper_clear(){
        //Given
        let country:String = "MCO"
        sut.set(country: country)
        let currentCountry = sut.getCountry()
        
        //When
        sut.clear()
        
        //Then
        XCTAssertNotEqual(currentCountry, sut.getCountry())
    }

}

