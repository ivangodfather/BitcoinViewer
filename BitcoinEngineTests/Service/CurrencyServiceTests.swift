//
//  BitcoinViewerTests.swift
//  BitcoinViewerTests
//
//  Created by Iván Ruiz on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import XCTest
import Nimble
@testable import BitcoinEngine

class CurrencyServiceTests: XCTestCase {
    
    var sut: CurrencyService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = CurrencyService()
    }
    
    func testCalculateVariation() {
        let prices: [Double] = [3, 1, 5, 8, 6.5]
        
        let result = sut.calculateVariation(list: prices)
        
        expect(result).to(equal([2, -4, -3, 1.5]))
    }

    
}
