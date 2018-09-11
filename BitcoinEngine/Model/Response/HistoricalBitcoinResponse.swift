//
//  BPI.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.

//

import Foundation

final class HistoricalBitcoinResponse: Decodable {
    
    let bpi: [String: Double]
    
}
