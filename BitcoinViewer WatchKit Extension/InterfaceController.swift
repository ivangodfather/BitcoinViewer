//
//  InterfaceController.swift
//  BitcoinViewer WatchKit Extension
//
//  Created by Iván Ruiz on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadData()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func loadData() {
        tableView.setNumberOfRows(Data().getData().count, withRowType: "RowController")
        for (index, row) in Data().getData().enumerated() {
            if let rowController = tableView.rowController(at: index) as? RowController {
                rowController.rowLabel.setText(row)
            }

        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print(rowIndex)
    }

}
