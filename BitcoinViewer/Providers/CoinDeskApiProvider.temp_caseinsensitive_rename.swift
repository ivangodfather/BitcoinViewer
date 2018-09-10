//
//  CoindeskProvider.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.
//  Copyright © 2018 Netquest. All rights reserved.
//

import Foundation
import Moya

let coinDeskProvider: MoyaProvider<CoinDeskAPI>()

enum CoinDeskAPI {
    case rates(startDate: String, endDate: String)
}

extension CoinDeskAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.coindesk.com/v1/bpi/")!
    }
    
    var path: String {
        switch self {
        case .rates: return "historical/close.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .rates(startDate, endDate):
            return .requestParameters(parameters: ["startDate": startDate, "endDate": endDate], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return  ["Content-Type": "application/json",
                 "Accept": "application/json"]
    }
    
    var sampleData: Foundation.Data { return Foundation.Data() }

    
    
}
