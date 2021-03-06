//
//  DetailItemViewControllerTests.swift
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

class DetailItemViewControllerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: DetailItemViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        window = UIWindow()
        setupDetailItemViewController()
    }
    
    override func tearDown(){
        window = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailItemViewController(){
        sut = DetailItemViewController()
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class DetailItemBusinessLogicSpy: DetailItemBusinessLogic{
        var loadInitialInformationCalled = false
        
        func loadInitialInformation(request: DetailItem.LoadInitalData.Request){
            loadInitialInformationCalled = true
        }
    }
    
    // MARK: Tests
    
    func testDetailItemViewController_WhenViewIsLoaded(){
        // Given
        let spy = DetailItemBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.loadInitialInformationCalled, "viewDidLoad() should ask the interactor to loadInitialInformation")
    }
    
    func testDetailItemViewControlle_WhenDisplayInitialInformation(){
        // Given
        guard let resultSearch = Seeds.items.searchResult?.results?.first else{
            XCTFail("Json is empty")
            return
            
        }

        let detail = [DetailDescription.init(title: NSLocalizedString("detailView.description.Title", comment: ""), detail:resultSearch.title ?? "" )]
        let viewModel = DetailItem.LoadInitalData.ViewModel(titleView: NSLocalizedString("appName", comment: ""), resultSearch:resultSearch , detail:detail)
        
        // When
        loadView()
        sut.displayInitialInformation(viewModel: viewModel)
        let cell = sut.detailTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ImageDetailTableViewCell
        
        
        
        // Then
        XCTAssertEqual(cell.conditionProductLabel.text, resultSearch.conditionDisplay, "displayInitialInformation(viewModel:) should update product condicion in the cell ImageDetailTableViewCell")
    }
}
