//
//  GetCoinsHistoryRepositorySpy.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import Foundation
import Combine
import DemoApp

class GetCoinsHistoryRepositorySpy: GetCoinsHistoryRepository {
    var invokedExecute = false
    var invokedExecuteCount = 0
    var invokedExecuteParameters: (id: String, date: String)?
    var stubbedExecuteResult: AnyPublisher<CoinsHistoryResponse, Error>!
    
    func getCoinHistory(id: String, date: String) -> AnyPublisher<CoinsHistoryResponse, Error> {
        invokedExecute = true
        invokedExecuteCount += 1
        invokedExecuteParameters = (id, date)
        return stubbedExecuteResult
    }
}
