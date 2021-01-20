//
//  LaunchScreenViewControllerTests.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.
//

@testable import ShopTest
import XCTest

class LaunchScreenViewControllerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: LaunchScreenViewController!
    var window: UIWindow!
    var viewModel:LaunchScreen.LoadInitalData.ViewModel!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        window = UIWindow()
        setupLaunchScreenViewController()
        viewModel = LaunchScreen.LoadInitalData.ViewModel(nameAnimation: NSLocalizedString("LaunchView.animationViewMane", comment: ""), type: "json", nameApp: NSLocalizedString("appName", comment: ""))
    }
    
    override func tearDown(){
        window = nil
        viewModel = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLaunchScreenViewController(){
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "LaunchScreenViewController") as? LaunchScreenViewController
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Given
    
    func givenLoadedView(){
        
    }
    
    // MARK: Test doubles
    
    class LaunchScreenBusinessLogicSpy: LaunchScreenBusinessLogic{
        var loadInitialInformationCalled = false
        
        func loadInitialInformation(request: LaunchScreen.LoadInitalData.Request) {
            loadInitialInformationCalled = true
        }
    }
    class LaunchScreenRoutingLogicSpy: NSObject, LaunchScreenRoutingLogic, LaunchScreenDataPassing{
        var routeToSearchViewCalled = false
        var dataStore: LaunchScreenDataStore?
        
        func routeToSearchView() {
            routeToSearchViewCalled = true
        }
        
    }
    
    // MARK: Tests
    
    func testShouldLoadInitialInformationIsCalledWhenViewIsLoaded(){
        // Given
        let spy = LaunchScreenBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.loadInitialInformationCalled, "viewDidLoad() should ask the interactor to loadInitialInformation ")
    }
    
    func testDisplayInitialInformation(){
        // Given
        
        // When
        loadView()
        sut.displayInitialInformation(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.nameAppLabel.text, viewModel.nameApp, "displayInitialInformation(viewModel:) should update the nameAppLabel text field")
        XCTAssertNotNil(sut.myAnimationView, "should not be nil when assigning a json")
    }
    
    func testShouldRouterToSearch(){
        //Given
        let spy = LaunchScreenRoutingLogicSpy()
        sut.router = spy
        //When
        loadView()
        sut.displayInitialInformation(viewModel: viewModel)
        let exp = expectation(description: "Animation loaded and ready to router to Search")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
        XCTAssertTrue(spy.routeToSearchViewCalled, "displayInitialInformation(viewModel:) should ask the router to navigate to Search View")
    }
}
