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
    
    init(bitcoinService: BitcoinServiceType = BitcoinService()) {
        self.bitcoinService = bitcoinService
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
            .map { State.loaded(bitcoinPrices: $0.0, realTime: $0.1) }
            .startWith(State.loading)
        
        return Output(state: state)
    }
    
    enum State {
        case loading
        case loaded(bitcoinPrices: [BitcoinPrice], realTime : BitcoinPrice?)
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
