//
//  BitcoinPrice.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation

public struct BitcoinPrice: Codable {
    public let date: String
    public let price: Double
}

extension BitcoinPrice: Equatable {
    public static func == (lhs: BitcoinPrice, rhs: BitcoinPrice) -> Bool {
        return lhs.date == rhs.date && lhs.price == rhs.price
    }
}
