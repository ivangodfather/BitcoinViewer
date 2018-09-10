//
//  Encondable+Extension.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation

extension Encodable {
    var asData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
