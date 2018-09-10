//
//  BitconService.swift
//  BitcoinViewer
//
//  Created by Iván Ruiz on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol BitcoinServiceType {
    func fetch(weeks: Int) -> Observable<[BitcoinPrice]>
}

final class BitcoinService: BitcoinServiceType {
    
    private let coinDeskApiProvider: MoyaProvider<CoinDeskAPI>
    
    init(coinDeskApiProvider: MoyaProvider<CoinDeskAPI> = MoyaProvider<CoinDeskAPI>()) {
        self.coinDeskApiProvider = coinDeskApiProvider
    }
    
    func fetch(weeks: Int) -> Observable<[BitcoinPrice]> {
        let startDate = Date().remove(weeks: weeks).shortFormat
        let endDate = Date().shortFormat
        return coinDeskApiProvider
            .rx
            .request(CoinDeskAPI.rates(startDate: startDate, endDate: endDate))
            .asObservable()
            .filterSuccessfulStatusCodes()
            .map(CoinDeskResponse.self)
            .map  { $0.bpi.map(BitcoinPrice.init) }
            .map({  bitcoinPrices in
                return bitcoinPrices.sorted {$0.date > $1.date }
            })
    }
    
}
