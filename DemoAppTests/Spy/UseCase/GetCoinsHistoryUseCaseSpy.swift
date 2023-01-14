//
//  GetCoinsHistoryUseCaseSpy.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import Foundation
import DemoApp
import Combine

class GetCoinsHistoryUseCaseSpy: GetCoinsHistoryUseCase {
    var invokedExecute = false
    var invokedExecuteCount = 0
    var invokedExecuteParameters: (id: String, date: String)?
    var stubbedExecuteResult: AnyPublisher<CoinsHistoryResponse, Error>!
    
    func execute(id: String, date: String) -> AnyPublisher<DemoApp.CoinsHistoryResponse, Error> {
        invokedExecute = true
        invokedExecuteCount += 1
        invokedExecuteParameters = (id, date)
        return stubbedExecuteResult
    }
}
