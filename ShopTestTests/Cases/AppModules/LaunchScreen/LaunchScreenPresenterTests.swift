//
//  LaunchScreenPresenterTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//

@testable import ShopTest
import XCTest

class LaunchScreenPresenterTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: LaunchScreenPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupLaunchScreenPresenter()
    }
    
    override func tearDown(){
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLaunchScreenPresenter(){
        sut = LaunchScreenPresenter()
    }
    
    // MARK: Test doubles
    
    class LaunchScreenDisplayLogicSpy: LaunchScreenDisplayLogic{
        var displayInitialInformationCalled = false
        func displayInitialInformation(viewModel: LaunchScreen.LoadInitalData.ViewModel){
            displayInitialInformationCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentSomething(){
        // Given
        let spy = LaunchScreenDisplayLogicSpy()
        sut.viewController = spy
        let response = LaunchScreen.LoadInitalData.Response()
        
        // When
        sut.presentInitialInformation(response: response)
        
        // Then
        XCTAssertTrue(spy.displayInitialInformationCalled, "presentInitialInformation(response:) should ask the view controller to display the result")
    }
}
