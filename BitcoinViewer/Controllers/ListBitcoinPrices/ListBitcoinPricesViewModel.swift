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
        let bitcoinPrices = input
            .viewWillAppear
            .map { _ in return 2 }
            .flatMap(bitcoinService.fetch)
        return Output(bitcoinPrices: bitcoinPrices)
    }
    
}

extension ListBitcoinPricesViewModel {
    
    struct Input {
        let viewWillAppear: Observable<()>
    }
    
    struct Output {
        let bitcoinPrices: Observable<[BitcoinPrice]>
    }
}
