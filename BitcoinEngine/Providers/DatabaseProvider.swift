//
//  DatabaseProvider.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation

protocol DatabaseProviderType {
    func saveBitcoinPrices(prices: [BitcoinPrice])
    func bitCoinPrices() -> [BitcoinPrice]
}

final class DatabaseProvider: DatabaseProviderType {

    private struct Keys {
        static let bitCoinPrices = "BITCOIN_PRICES"
    }
    
    func saveBitcoinPrices(prices: [BitcoinPrice]) {
        UserDefaults.standard.set(prices.asData, forKey: Keys.bitCoinPrices)
        UserDefaults.standard.synchronize()
    }
    
    func bitCoinPrices() -> [BitcoinPrice] {
        if let data = UserDefaults.standard.data(forKey: Keys.bitCoinPrices),
            let bitCoinPrices = try? JSONDecoder().decode([BitcoinPrice].self, from: data){
            return bitCoinPrices
        }
        return []
    }
}
