//
//  GetCoinsHistoryUseCase.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Foundation
import Combine

public protocol GetCoinsHistoryUseCase {
    func execute(id: String, date: String) -> AnyPublisher<CoinsHistoryResponse, Error>
}

public class GetCoinsHistoryUseCaseImpl: GetCoinsHistoryUseCase {
    private let repository: GetCoinsHistoryRepository
    
    public init(repository: GetCoinsHistoryRepository = GetCoinsHistoryRepositoryImpl()) {
        self.repository = repository
    }
    
    public func execute(id: String, date: String) -> AnyPublisher<CoinsHistoryResponse, Error> {
        return repository
                .getCoinHistory(id: id, date: date)
                .eraseToAnyPublisher()
    }
}
