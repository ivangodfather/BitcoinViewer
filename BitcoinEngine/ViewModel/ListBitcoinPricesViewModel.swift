//
//  ListBitcoinPricesViewModel.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation
import RxSwift

public final class ListBitcoinPricesViewModel: ViewModelType {
    
    private let bitcoinService: BitcoinServiceType
    private let currencyService: CurrencyServiceType
    
    init(bitcoinService: BitcoinServiceType = BitcoinService(),
         currencyService: CurrencyServiceType = CurrencyService()) {
        self.bitcoinService = bitcoinService
        self.currencyService = currencyService
    }
    
    public init() {
        self.bitcoinService = BitcoinService()
        self.currencyService = CurrencyService()
    }
    
    public func transform(input: Input) -> Output {
        
        let realTime = bitcoinService.realTime().map { bitcoinPrice -> BitcoinPrice? in
            return bitcoinPrice
        }.startWith(nil)
        let state = input
            .viewWillAppear
            .map { _ in return 2 }
            .flatMap(bitcoinService.fetch)
            .map { [currencyService] bitcoinPrices in
                let variations = currencyService.calculateVariation(list: bitcoinPrices.map { $0.price })
                return State.loaded(bitcoinPrices: bitcoinPrices,
                                    realTime: realTime,
                                    variations: variations)
            }
            .startWith(State.loading)
        
        return Output(state: state)
    }
    
    public enum State: Equatable {
        
        case loading
        case loaded(bitcoinPrices: [BitcoinPrice], realTime : Observable<BitcoinPrice?>, variations: [Double])
        
        public static func == (lhs: ListBitcoinPricesViewModel.State, rhs: ListBitcoinPricesViewModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.loaded(let lbitcoinprices, _, let lvariations), .loaded(let rbitcoinprices, _, let rvariations)):
                return lbitcoinprices == rbitcoinprices && lvariations == rvariations
            default:
                return false
            }
        }
    }
}

public extension ListBitcoinPricesViewModel {
    
    public struct Input {
        public let viewWillAppear: Observable<()>
        
        public init(viewWillAppear: Observable<()>) {
                self.viewWillAppear = viewWillAppear
        }
    }
    public struct Output {
        public let state: Observable<State>
    }
    
}
