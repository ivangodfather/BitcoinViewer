//
//  ListBitcoinPricesViewModelTests.swift
//  BitcoinEngineTests
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.

//

import XCTest
@testable import BitcoinEngine
import RxSwift
import RxBlocking
import Nimble

final class ListBitcoinPricesViewModelTests: XCTestCase {
    
    private var sut: ListBitcoinPricesViewModel!
    private let mockBitcoinService = MockBitcoinService()
    private let mockCurrencyService = MockCurrencyService()
    
    override func setUp() {
        super.setUp()
        sut = ListBitcoinPricesViewModel(bitcoinService: mockBitcoinService, currencyService: mockCurrencyService)
    }
    
    func testFirstStateIsLoading() {
        let input = ListBitcoinPricesViewModel.Input(viewWillAppear: .just(()))
        
        let output = sut.transform(input: input)
        
        let state = try! output.state.toBlocking().first()!
        let expectedState = ListBitcoinPricesViewModel.State.loading
        expect(state).to(equal(expectedState))
    }
    
    func testRequestTwoWeeksForBitcoinPrices() {
        let input = ListBitcoinPricesViewModel.Input(viewWillAppear: .just(()))
        
        _ = try? sut.transform(input: input).state.toBlocking().first()
        
        expect(self.mockBitcoinService.weeksToFetch).to(equal(2))
    }
    
    func testExpectVariationList() {
        let input = ListBitcoinPricesViewModel.Input(viewWillAppear: .just(()))
        mockBitcoinService.valuesToReturn = valuesToReturn()
        
        _ = try? sut.transform(input: input).state.toBlocking().first()
        
        expect(self.mockCurrencyService.receivedList).to(equal([100, 200, 300]))
    }
    
    func testsOutputCorrectFinishStateValues() {
        let input = ListBitcoinPricesViewModel.Input(viewWillAppear: .just(()))
        mockBitcoinService.valuesToReturn = valuesToReturn()
        
        let state = try! sut.transform(input: input).state.toBlocking().last()!

        expect(state).toNot(equal(ListBitcoinPricesViewModel.State.loading))
        if case let ListBitcoinPricesViewModel.State.loaded(bitcoinPrices, _, _) = state {
            expect(bitcoinPrices).to(equal(valuesToReturn()))
        }
    }
    
    private func valuesToReturn() -> [BitcoinPrice] {
        return [BitcoinPrice(date: "1", price: 100),
                BitcoinPrice(date: "2", price: 200),
                BitcoinPrice(date: "3", price: 300)]
    }

    
}
