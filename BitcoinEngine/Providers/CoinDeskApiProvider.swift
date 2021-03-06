//
//  CoindeskProvider.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.

//

import Foundation
import Moya

enum CoinDeskAPI {
    case rates(startDate: String, endDate: String)
    case realTime
}

extension CoinDeskAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.coindesk.com/v1/bpi/")!
    }
    
    var path: String {
        switch self {
        case .rates: return "historical/close.json"
        case .realTime: return "currentprice/EUR.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .rates(startDate, endDate):
            return .requestParameters(parameters: ["currency": "EUR", "start": startDate, "end": endDate], encoding: URLEncoding.default)
        default: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return  ["Content-Type": "application/json",
                 "Accept": "application/json"]
    }
    
    var sampleData: Foundation.Data {
        switch self {
        case .rates: return loadJson(file: "rates")
        case .realTime: return loadJson(file: "realtime")
        }
    }
    
    private func loadJson(file: String) -> Data {
        guard let url = Bundle.main.url(forResource: file,
                                        withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }

}
