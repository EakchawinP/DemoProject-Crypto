//
//  GetCoinsListUseCase.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Foundation
import Combine

public protocol GetCoinsListUseCase {
    func execute() -> AnyPublisher<CoinsListResponse, Error>
}

public class GetCoinsListUseCaseImpl: GetCoinsListUseCase {
    private let repository: GetCoinsListRepository
    
    public init(repository: GetCoinsListRepository = GetCoinsListRepositoryImpl()) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<CoinsListResponse, Error> {
        return repository
                .getCoinList()
                .eraseToAnyPublisher()
    }
}
