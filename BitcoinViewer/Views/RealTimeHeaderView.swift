//
//  RealTimeHeaderView.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.

//

import UIKit
import BitcoinEngine

final class RealTimeHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    func setup(bitcoinPrice: BitcoinPrice) {
        priceLabel.text = "🤑 " + bitcoinPrice.price.description
        dateLabel.text = "🕑 " + bitcoinPrice.date + " (Now)"
    }
    
}
