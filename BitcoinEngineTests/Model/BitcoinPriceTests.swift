//
//  BitcoinPrice.swift
//  BitcoinViewerTests
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.

//

import XCTest
import Nimble
@testable import BitcoinEngine

class BitcoinPriceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testInitShouldCreateCorrectObject() {
        let date = "1985-15-3"
        let price = 150.65
        
        let object = BitcoinPrice(date: date, price: price)
        
        expect(object.date).to(equal(date))
        expect(object.price).to(equal(price))
    }
    
    
}
