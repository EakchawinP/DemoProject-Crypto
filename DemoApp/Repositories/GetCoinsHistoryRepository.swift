//
//  GetCoinsHistoryRepository.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Foundation
import Combine
import Moya

public protocol GetCoinsHistoryRepository {
    func getCoinHistory(id: String, date: String) -> AnyPublisher<CoinsHistoryResponse, Error>
}

public class GetCoinsHistoryRepositoryImpl: GetCoinsHistoryRepository {
    private var provider: MoyaProvider<CoinsAPI>
    
    public init(provider: MoyaProvider<CoinsAPI> = MoyaProvider<CoinsAPI>()) {
        self.provider = provider
    }
    
    public func getCoinHistory(id: String, date: String) -> AnyPublisher<CoinsHistoryResponse, Error> {
        return provider
                .cb
                .request(.getCoinHistory(id: id, date: date))
                .map(CoinsHistoryResponse.self)
                .eraseToAnyPublisher()
    }
}
