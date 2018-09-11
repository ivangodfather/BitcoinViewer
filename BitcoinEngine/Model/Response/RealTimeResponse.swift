//
//  RealTimeResponse.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.

//

import Foundation

final class RealTimeResponse: Decodable {
    
    private let rate_float: Double
    
}

extension RealTimeResponse {
    
    var rate: Double { return rate_float }
    
}
