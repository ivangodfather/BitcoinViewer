//
//  BitcoinViewerUITests.swift
//  BitcoinViewerUITests
//
//  Created by Iván Ruiz on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
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

    
    func testShows2WeeksOfCells() {
        let cellCount = app.tables.element(boundBy: 0).cells.count
        XCTAssertTrue(cellCount == 14)
    }
    

    
}
