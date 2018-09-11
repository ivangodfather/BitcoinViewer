//
//  MockCurrencyService.swift
//  BitcoinEngineTests
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.

//

import Foundation
@testable import BitcoinEngine

final class MockCurrencyService: CurrencyServiceType {
    
    var receivedList: [Double]?
    
    func calculateVariation(list: [Double]) -> [Double] {
        receivedList = list
        return []
    }
}
