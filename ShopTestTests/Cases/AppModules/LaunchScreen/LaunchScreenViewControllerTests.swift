//
//  LaunchScreenViewControllerTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//

@testable import ShopTest
import XCTest

class LaunchScreenViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: LaunchScreenViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupLaunchScreenViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupLaunchScreenViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "LaunchScreen", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "LaunchScreenViewController") as! LaunchScreenViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class LaunchScreenBusinessLogicSpy: LaunchScreenBusinessLogic
  {
    var loadInitialInformationCalled = false
    
    func loadInitialInformation(request: LaunchScreen.LoadInitalData.Request) {
        loadInitialInformationCalled = true
    }
  }
  
  // MARK: Tests
  
  func testShouldDoSomethingWhenViewIsLoaded()
  {
    // Given
    let spy = LaunchScreenBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    
    // Then
    XCTAssertTrue(spy.loadInitialInformationCalled, "viewDidLoad() should ask the interactor to do loadInitialInformation ")
  }
  
  func testDisplaySomething()
  {
    // Given
    let viewModel = LaunchScreen.LoadInitalData.ViewModel(nameAnimation: "shoppingBag", type: "json", nameApp: "Shopping")
    
    // When
    loadView()
    sut.displayInitialInformation(viewModel: viewModel)
    
    // Then
    XCTAssertEqual(sut.nameAppLabel.text, viewModel.nameApp, "displayInitialInformation(viewModel:) should update the nameAppLabel text field")
    XCTAssertNotNil(sut.myAnimationView, "should not be nil when assigning a json")
  }
}
