//
//  GetCoinsHistoryRepositoryTests.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import XCTest
import Combine
import Moya
@testable import DemoApp

final class GetCoinsHistoryRepositoryTests: XCTestCase {
    private var anyCancellable: Set<AnyCancellable> = .init()
    let customEndpointClosure = { (target: CoinsAPI) -> Endpoint in
        Endpoint(url: URL(target: target).absoluteString,
                 sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                 method: target.method,
                 task: target.task,
                 httpHeaderFields: target.headers)
    }
    
    func test_GetCoinHistory_ShouldBeSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "GetCoinHistory should be success")
        let provider = MoyaProvider<CoinsAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        let sut = GetCoinsHistoryRepositoryImpl(provider: provider)
        var response: CoinsHistoryResponse?
        let id = "abachi"
        let date = "14-01-2023"
        
        // When
        sut.getCoinHistory(id: id, date: date).sink { completion in
            switch completion {
            case .failure:
                XCTFail()
            default: break
            }
        } receiveValue: { result in
            response = result
            expectation.fulfill()
        }
        .store(in: &anyCancellable)
        wait(for: [expectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(response)
    }
}
