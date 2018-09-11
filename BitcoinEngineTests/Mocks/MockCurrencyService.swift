//
//  MockCurrencyService.swift
//  BitcoinEngineTests
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
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
