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
import BitcoinEngine

final class ListBitcoinPricesViewController: UIViewController {
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = ListBitcoinPricesViewModel()
    private  let bitcoinPriceCellName = String(describing: BitcoinPriceTableViewCell.self)
    private lazy var realTimeHeaderView: RealTimeHeaderView? = { return UINib(nibName: String(describing: RealTimeHeaderView.self), bundle: nil).instantiate(withOwner: self, options: nil).first as? RealTimeHeaderView
    }()
    private var bitcoinPrices: [BitcoinPrice] = [] {
        didSet { tableView.reloadData() }
    }
    private var variations: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let viewWillAppear = rx.viewWillAppear.asObservable().map { _ in return }
        let input = ListBitcoinPricesViewModel.Input(viewWillAppear: viewWillAppear)
        let output = viewModel.transform(input: input)
        output.state.subscribe(onNext: { [weak self] state in
            guard let strongSelf = self else { return }
            switch state {
            case .loading:
                self?.activityIndicatorView.startAnimating()
            case .loaded(let bitcoinPrices, let bitcoinRealTime, let variations):
                self?.bitcoinPrices = bitcoinPrices
                self?.variations = variations
                bitcoinRealTime.subscribe(onNext: { bitcoinRealTime in
                    if let realTime = bitcoinRealTime {
                        self?.activityIndicatorView.stopAnimating()
                        self?.realTimeHeaderView?.setup(bitcoinPrice: realTime)
                    }
                }).disposed(by: strongSelf.rx.disposeBag)

            }
        }).disposed(by: rx.disposeBag)
    }
    
    private func setupView() {
        tableView.register(UINib(nibName: bitcoinPriceCellName, bundle: nil),
                           forCellReuseIdentifier: bitcoinPriceCellName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = realTimeHeaderView
        var frame = tableView.tableHeaderView?.frame
        frame?.size.height = 40
        tableView.tableHeaderView?.frame = frame!
        tableView.tableHeaderView = tableView.tableHeaderView
    }
    
}

extension ListBitcoinPricesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bitcoinPriceCellName) as? BitcoinPriceTableViewCell ?? BitcoinPriceTableViewCell()
        let bitcoinPrice = bitcoinPrices[indexPath.row]
        let variation = indexPath.row < variations.count ? variations[indexPath.row] : nil
        cell.setup(bitcoinPrice: bitcoinPrice, variation: variation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bitcoinPrices.count
    }
    
}
