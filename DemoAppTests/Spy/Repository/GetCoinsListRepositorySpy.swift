//
//  GetCoinsListRepositorySpy.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import Foundation
import DemoApp
import Combine

class GetCoinsListRepositorySpy: GetCoinsListRepository {
    var invokedExecute = false
    var invokedExecuteCount = 0
    var stubbedExecuteResult: AnyPublisher<CoinsListResponse, Error>!
    
    func getCoinList() -> AnyPublisher<CoinsListResponse, Error> {
        invokedExecute = true
        invokedExecuteCount += 1
        return stubbedExecuteResult
    }
}
