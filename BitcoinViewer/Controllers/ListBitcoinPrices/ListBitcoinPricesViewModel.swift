//
//  ListBitcoinPricesViewModel.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation
import RxSwift

final class ListBitcoinPricesViewModel: ViewModelType {
    
    private let bitcoinService: BitcoinServiceType
    private let currencyService: CurrencyServiceType
    
    init(bitcoinService: BitcoinServiceType = BitcoinService(),
         currencyService: CurrencyServiceType = CurrencyService()) {
        self.bitcoinService = bitcoinService
        self.currencyService = currencyService
    }
    
    func transform(input: Input) -> Output {
        let state = input
            .viewWillAppear
            .map { _ in return 2 }
            .flatMap(bitcoinService.fetch)
            .flatMap({ [bitcoinService] bitCoinPrices  in
                return bitcoinService.realTime()
                    .map { bitcoinPrice -> BitcoinPrice? in
                        return bitcoinPrice
                    }
                    .startWith(nil).map { (bitCoinPrices, $0) }
            })
            .map { [currencyService] tuple in
                let variations = currencyService.calculateVariation(list: tuple.0.map { $0.price })
                return State.loaded(bitcoinPrices: tuple.0,
                                    realTime: tuple.1,
                                    variations: variations)
            }
            .startWith(State.loading)
        
        return Output(state: state)
    }
    
    enum State {
        case loading
        case loaded(bitcoinPrices: [BitcoinPrice], realTime : BitcoinPrice?, variations: [Double])
    }
}

extension ListBitcoinPricesViewModel {
    
    struct Input {
        let viewWillAppear: Observable<()>
    }
    struct Output {
        let state: Observable<State>
    }
    
}
