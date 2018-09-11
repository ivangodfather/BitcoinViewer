//
//  TodayViewController.swift
//  Bitcoin Widget
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import UIKit
import NotificationCenter
import RxViewController
import NSObject_Rx

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var textLabel: UILabel!
    private let viewModel = ListBitcoinPricesViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let input = ListBitcoinPricesViewModel.Input(viewWillAppear: rx.viewWillAppear.asObservable().map { _ in return })
        let output = viewModel.transform(input: input)
        output.state.subscribe(onNext: { [weak self] state in
            switch state {
            case .loading:
                break
            case .loaded(_, let realTime, _):
                self?.textLabel.text = realTime?.price.description
            }
        }).disposed(by: rx.disposeBag)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
