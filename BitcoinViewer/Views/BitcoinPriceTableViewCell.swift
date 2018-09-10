//
//  BitcoinPriceTableViewCell.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import UIKit

final class BitcoinPriceTableViewCell: UITableViewCell {
    
    func setup(bitcoinPrice: BitcoinPrice) {
        self.textLabel?.text = bitcoinPrice.price.description
        self.detailTextLabel?.text = bitcoinPrice.date
    }
    
}
