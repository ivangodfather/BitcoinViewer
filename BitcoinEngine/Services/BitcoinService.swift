//
//  BitconService.swift
//  BitcoinViewer
//
//  Created by Iván Ruiz on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol BitcoinServiceType {
    func fetch(weeks: Int) -> Observable<[BitcoinPrice]>
    func realTime() -> Observable<BitcoinPrice>
}

final class BitcoinService: BitcoinServiceType {
    
    private let coinDeskApiProvider: MoyaProvider<CoinDeskAPI>
    private let databaseProvider: DatabaseProviderType
    
    init(coinDeskApiProvider: MoyaProvider<CoinDeskAPI> = MoyaProvider<CoinDeskAPI>(),
         databaseProvider: DatabaseProviderType = DatabaseProvider()) {
        self.coinDeskApiProvider = coinDeskApiProvider
        self.databaseProvider = databaseProvider
    }
    
    func fetch(weeks: Int) -> Observable<[BitcoinPrice]> {
        let startDate = Date().remove(weeks: weeks).shortFormat
        let endDate = Date().shortFormat
        return coinDeskApiProvider
            .rx
            .request(CoinDeskAPI.rates(startDate: startDate, endDate: endDate))
            .asObservable()
            .filterSuccessfulStatusCodes()
            .map(HistoricalBitcoinResponse.self)
            .map  { $0.bpi.map(BitcoinPrice.init) }
            .map({  bitcoinPrices in
                return bitcoinPrices.sorted {$0.date > $1.date }
            })
            .do(onNext: { [databaseProvider] bitcoinPrices in
                databaseProvider.saveBitcoinPrices(prices: bitcoinPrices)
            })
            .startWith(databaseProvider.bitCoinPrices())
    }
    
    func realTime() -> Observable<BitcoinPrice> {
        let bitcoinPrice = coinDeskApiProvider
            .rx
            .request(.realTime)
            .asObservable()
            .filterSuccessfulStatusCodes()
            .map(RealTimeResponse.self, atKeyPath: "bpi.EUR")
            .map({ realTimeResponse -> BitcoinPrice in
               return BitcoinPrice(date: Date().longFormat, price: realTimeResponse.rate)
            })
        return Observable<Int>.interval(1.0, scheduler: MainScheduler.instance).flatMap { _ in
            return bitcoinPrice
        }
    }
    
}
