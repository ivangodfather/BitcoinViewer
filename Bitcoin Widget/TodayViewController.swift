//
//  TodayViewController.swift
//  Bitcoin Widget
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.

//

import UIKit
import NotificationCenter
import BitcoinEngine
import RxSwift
import RxViewController
import NSObject_Rx

final class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var textLabel: UILabel!
    private let viewModel = ListBitcoinPricesViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let input = ListBitcoinPricesViewModel.Input(viewWillAppear: rx.viewWillAppear.asObservable().map { _ in return })
        let output = viewModel.transform(input: input)
        output.state.subscribe(onNext: { [weak self] state in
            guard let strongSelf = self else { return }
            switch state {
            case .loading:
                break
            case .loaded(_, let realTime, _):
                realTime.subscribe(onNext: { realTime in
                    self?.textLabel.text = realTime?.price.description
                }).disposed(by: strongSelf.rx.disposeBag)
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
