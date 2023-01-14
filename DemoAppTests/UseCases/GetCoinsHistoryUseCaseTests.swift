//
//  GetCoinsHistoryUseCaseTests.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import XCTest
import Combine
@testable import DemoApp

final class GetCoinsHistoryUseCaseTests: XCTestCase {
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    func test_GetgetCoinHistory_ShouldBeSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "GetgetCoinHistory should be success")
        let coinsHistoryReponse = try! DataMockManager<CoinsHistoryResponse>.get(name: "CoinsHistoryResponse")
        let spy = GetCoinsHistoryRepositorySpy()
        spy.stubbedExecuteResult = Just(coinsHistoryReponse).setFailureType(to: Error.self).eraseToAnyPublisher()
        let sut = GetCoinsHistoryUseCaseImpl(repository: spy)
        var response: CoinsHistoryResponse?
        let id = "abachi"
        let date = "14-01-2023"
        
        // When
        sut.execute(id: id, date: date).sink { completion in
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
        XCTAssertTrue(spy.invokedExecute)
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.id ?? "", "abachi")
        XCTAssertEqual(response?.marketData?.currentPrice?.value ?? 0, 2.3045235989218615)
    }
}
