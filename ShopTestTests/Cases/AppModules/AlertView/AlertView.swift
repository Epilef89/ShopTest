//
//  AlertView.swift
//  ShopTestTests
//
//  Created by david cortes on 19/01/21.
//

import XCTest
@testable import ShopTest

class AlertView: XCTestCase {
    
    // MARK: Subject under test
    var sut:AlertViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    //MARK: Test
    
    func testAlertView_WhenIsLoadedOnlyWithOneButton(){
        //Given
        let titleButton = NSLocalizedString("aceptButton", comment: "")
        let message = "Unit Test"
        let completion = {}
        sut = AlertViewController(mainText: message, actionButtonTitle: titleButton, firstSelector: completion)
        
        //When
        sut.loadView()
        sut.viewDidLoad()
        
        //Then
        XCTAssertEqual(sut.messageLabel.text, message)
        XCTAssertEqual(sut.primaryButton.title(for: .normal), titleButton)
        
        
    }
    
    func testAlertView_WhenIsLoadedOnlyWithTwoButton(){
        //Given
        let confirmButton = NSLocalizedString("aceptButton", comment: "")
        let cancelButton = NSLocalizedString("cancelButton", comment: "")
        let message = "Unit Test"
        let completion = {}
        sut = AlertViewController(mainText: message, actionButtonTitle: confirmButton, firstSelector: completion, secundaryButtonTitle: cancelButton, secondSelector: completion)
        
        //When
        sut.loadView()
        sut.viewDidLoad()
        
        //Then
        XCTAssertEqual(sut.messageLabel.text, message)
        XCTAssertEqual(sut.primaryButton.title(for: .normal), confirmButton)
        XCTAssertEqual(sut.secundaryButton.title(for: .normal), cancelButton)
        
        
    }
    
    func testAlertView_WhenInShowAlertPrimaryButtonIsTapped(){
        //Given
        var callaction:Bool = false
        sut = AlertViewController(mainText: "", actionButtonTitle: NSLocalizedString("", comment: ""), firstSelector: {
            callaction = true
        })
        
        //When
        sut.loadView()
        sut.actionPrimaryButton()
        
        //Then
        XCTAssertTrue(callaction, "Primary action don't call completion action.")
    }
    
    
    

}
