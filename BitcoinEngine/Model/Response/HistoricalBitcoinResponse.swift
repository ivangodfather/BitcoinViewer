//
//  BPI.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation

final class HistoricalBitcoinResponse: Decodable {
    
    let bpi: [String: Double]
    
}
