//
//  ListBitcoinPricesViewModelTests.swift
//  BitcoinEngineTests
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import XCTest
@testable import BitcoinEngine
import RxSwift

final class ListBitcoinPricesViewModelTests: XCTestCase {
    
    private var sut: ListBitcoinPricesViewModel!
    private let mockBitcoinService = MockBitcoinService()
    private let mockCurrencyService = MockCurrencyService()
    
    override func setUp() {
        super.setUp()
        sut = ListBitcoinPricesViewModel(bitcoinService: mockBitcoinService, currencyService: mockCurrencyService)
    }

    
}
