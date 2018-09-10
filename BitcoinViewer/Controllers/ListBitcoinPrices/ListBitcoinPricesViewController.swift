//
//  ListBitcoinPricesViewController.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import UIKit
import NSObject_Rx
import RxViewController

final class ListBitcoinPricesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = ListBitcoinPricesViewModel()
    private  let bitcoinPriceCellName = String(describing: BitcoinPriceTableViewCell.self)

    private var bitcoinPrices: [BitcoinPrice] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let input = ListBitcoinPricesViewModel.Input(viewWillAppear: rx.viewWillAppear.asObservable().map { _ in return })
        let output = viewModel.transform(input: input)
        output.bitcoinPrices.subscribe(onNext: { [weak self] bitcoinPrices in
            self?.bitcoinPrices = bitcoinPrices
        }).disposed(by: rx.disposeBag)
    }
    
    private func setupView() {
        tableView.register(UINib(nibName: bitcoinPriceCellName, bundle: nil), forCellReuseIdentifier: bitcoinPriceCellName)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ListBitcoinPricesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bitcoinPriceCellName) as? BitcoinPriceTableViewCell ?? BitcoinPriceTableViewCell()
        let bitcoinPrice = bitcoinPrices[indexPath.row]
        cell.setup(bitcoinPrice: bitcoinPrice)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bitcoinPrices.count
    }

}
