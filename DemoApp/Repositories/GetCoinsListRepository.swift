//
//  GetCoinsListRepository.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Foundation
import Combine
import Moya

public protocol GetCoinsListRepository {
    func getCoinList() -> AnyPublisher<CoinsListResponse, Error>
}

public class GetCoinsListRepositoryImpl: GetCoinsListRepository {
    
    private var provider: MoyaProvider<CoinsAPI>
    
    public init(provider: MoyaProvider<CoinsAPI> = MoyaProvider<CoinsAPI>()) {
        self.provider = provider
    }
    
    public func getCoinList() -> AnyPublisher<CoinsListResponse, Error> {
        return provider
                .cb
                .request(.getCoinsList)
                .map(CoinsListResponse.self)
                .eraseToAnyPublisher()
    }
}
