//
//  CoinsAPI.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Foundation
import Moya

public enum CoinsAPI {
    case getCoinsList
    case getCoinHistory(id: String, date: String)
}

extension CoinsAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.coingecko.com/api/v3")!
    }
    
    public var path: String {
        switch self {
        case .getCoinsList:
            return "/coins/list"
        case let .getCoinHistory(id, _):
            return "coins/\(id)/history"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        switch self {
        case .getCoinsList:
            return GetJsonFile.shared.readLocalFile(forName: "CoinsListResponse")
        case .getCoinHistory(_, _):
            return GetJsonFile.shared.readLocalFile(forName: "CoinsHistoryResponse")
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .getCoinsList:
            return .requestPlain
        case let .getCoinHistory(_, date):
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
