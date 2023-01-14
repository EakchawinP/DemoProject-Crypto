//
//  GetCoinsListUseCaseSpy.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import Foundation
import DemoApp
import Combine

class GetCoinsListUseCaseSpy: GetCoinsListUseCase {
    var invokedGetCoinsList = false
    var invokedGetCoinsListCount = 0
    var stubbedGetCoinsListResult: AnyPublisher<CoinsListResponse, Error>!
    
    func execute() -> AnyPublisher<CoinsListResponse, Error> {
        invokedGetCoinsList = true
        invokedGetCoinsListCount += 1
        return stubbedGetCoinsListResult
    }
}
