//
//  CurrencyService.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.

//

import Foundation

protocol CurrencyServiceType {
    func calculateVariation(list: [Double]) -> [Double]
}

final class CurrencyService: CurrencyServiceType {
    
    func calculateVariation(list: [Double]) -> [Double] {
        var variations = [Double]()
        list.enumerated().forEach { index, element in
            guard index + 1 < list.count else { return }
            variations.append(element - list[index + 1])
        }
        return variations
    }
    
}
