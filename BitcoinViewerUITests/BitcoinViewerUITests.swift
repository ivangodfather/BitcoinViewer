//
//  BitcoinViewerUITests.swift
//  BitcoinViewerUITests
//
//  Created by Iván Ruiz on 10/09/2018.

//

import XCTest

final class BitcoinViewerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UI_TESTS"]
        app.launch()

    }
    
    func testShowsCorrectValuesInFirstCell() {
        let firstDateLabel = app.tables.cells.staticTexts["2018-09-10"]
        XCTAssertFalse(firstDateLabel.exists)
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: firstDateLabel, handler: nil)
        waitForExpectations(timeout: 8, handler: nil)
        XCTAssert(firstDateLabel.exists)
    }
    

    
}
