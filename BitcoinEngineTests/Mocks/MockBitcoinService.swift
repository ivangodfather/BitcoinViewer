//
//  MockBitcoinService.swift
//  BitcoinEngineTests
//
//  Created by Ivan Ruiz Monjo on 11/09/2018.

//

import Foundation
@testable import BitcoinEngine
import RxSwift

final class MockBitcoinService: BitcoinServiceType {
    
    var weeksToFetch: Int = 0
    var valuesToReturn: [BitcoinPrice]?
    
    func fetch(weeks: Int) -> Observable<[BitcoinPrice]> {
        weeksToFetch = weeks
        if let valuesToReturn = valuesToReturn {
            return .just(valuesToReturn)
        }
        return .empty()
    }
    
    func realTime() -> Observable<BitcoinPrice> {
        return .empty()
    }
}
