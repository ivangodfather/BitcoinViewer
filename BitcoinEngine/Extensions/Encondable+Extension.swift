//
//  Encondable+Extension.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.

//

import Foundation

extension Encodable {
    
    var asData: Data? {
        return try? JSONEncoder().encode(self)
    }
    
}
