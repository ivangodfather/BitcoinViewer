//
//  RealTimeResponse.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation

final class RealTimeResponse: Decodable {
    
    private let rate_float: Double
    
}

extension RealTimeResponse {
    
    var rate: Double { return rate_float }
    
}
