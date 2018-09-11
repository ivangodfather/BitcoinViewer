//
//  InterfaceController.swift
//  BitcoinViewer WatchKit Extension
//
//  Created by Iván Ruiz on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import WatchKit
import Foundation
import RxSwift
import BitcoinEngineWatch
    
final class InterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    private let viewModel = ListBitcoinPricesViewModel()
    private let viewWillAppearPublishSubject = PublishSubject<()>()
    private var bitcoinPrices = [BitcoinPrice]() {
        didSet {
            loadData()
        }
    }
    private let disposeBag = DisposeBag()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let input = ListBitcoinPricesViewModel.Input(viewWillAppear: viewWillAppearPublishSubject.asObservable().map { _ in return })
        let output = viewModel.transform(input: input)
        output.state.subscribe(onNext: { [weak self] state in
            switch state {
            case .loading:
                break
            case .loaded(let bitcoinPrices, _, _):
                self?.bitcoinPrices = bitcoinPrices
            }
        }).disposed(by: disposeBag)
    }
    
    private func loadData() {
        tableView.setNumberOfRows(bitcoinPrices.count, withRowType: "RowController")
        for (index, bitcoinPrice) in bitcoinPrices.enumerated() {
            if let rowController = tableView.rowController(at: index) as? RowController {
                rowController.rowLabel.setText(bitcoinPrice.date + "\n" + bitcoinPrice.price.description)
            }
        }
    }
    
    override func willActivate() {
        super.willActivate()
        viewWillAppearPublishSubject.onNext(())
    }
    
}
