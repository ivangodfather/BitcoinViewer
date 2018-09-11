//
//  DatabaseProviderTests.swift
//  BitcoinEngineTests
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.

//

import XCTest
import Nimble
@testable import BitcoinEngine

final class DatabaseProviderTests: XCTestCase {
    
    private var sut: DatabaseProvider!
    
    override func setUp() {
        super.setUp()
        sut = DatabaseProvider()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSavesAndRetreivesSameBitcoinPrices() {
        let bitcoinPrices = [BitcoinPrice(date: "1", price: 100.5), BitcoinPrice(date: "2", price: 200)]
        
        sut.saveBitcoinPrices(prices: bitcoinPrices)
        
        expect(self.sut.bitCoinPrices()).to(equal(bitcoinPrices))
    }
    
}
