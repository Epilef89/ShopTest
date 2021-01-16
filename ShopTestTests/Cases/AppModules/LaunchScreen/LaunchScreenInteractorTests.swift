//
//  LaunchScreenInteractorTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//

@testable import ShopTest
import XCTest

class LaunchScreenInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: LaunchScreenInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupLaunchScreenInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupLaunchScreenInteractor()
  {
    sut = LaunchScreenInteractor()
  }
  
  // MARK: Test doubles
  
  class LaunchScreenPresentationLogicSpy: LaunchScreenPresentationLogic
  {
    var presentInitialInformationCalled = false
    
    func presentInitialInformation(response: LaunchScreen.LoadInitalData.Response) {
        presentInitialInformationCalled = true
    }

  }
  
  // MARK: Tests
  
  func test()
  {
    // Given
    let spy = LaunchScreenPresentationLogicSpy()
    sut.presenter = spy
    let request = LaunchScreen.LoadInitalData.Request()
    
    // When
    sut.loadInitialInformation(request: request)
    
    // Then
    XCTAssertTrue(spy.presentInitialInformationCalled, "loadInitialInformation(request:) should ask the presenter to format the result")
  }
}
