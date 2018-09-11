//
//  BitcoinPriceTableViewCell.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.

//

import UIKit
import BitcoinEngine

final class BitcoinPriceTableViewCell: UITableViewCell {
    
    func setup(bitcoinPrice: BitcoinPrice, variation: Double?) {
        textLabel?.text = bitcoinPrice.price.description
        detailTextLabel?.text = bitcoinPrice.date
        imageView?.image = (variation ?? 0.0) > 0.0 ? #imageLiteral(resourceName: "up") : #imageLiteral(resourceName: "down")
        imageView?.contentMode = .scaleAspectFit
    }
    
}
