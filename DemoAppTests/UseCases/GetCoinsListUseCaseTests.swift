//
//  GetCoinsListUseCaseTests.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import XCTest
import Combine
@testable import DemoApp

final class GetCoinsListUseCaseTests: XCTestCase {
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    func test_GetCoinsList_ShouldBeSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "GetCoinsListUseCase should be success")
        let coinsListReponse = try! DataMockManager<CoinsListResponse>.get(name: "CoinsListResponse")
        let spy = GetCoinsListRepositorySpy()
        spy.stubbedExecuteResult = Just(coinsListReponse).setFailureType(to: Error.self).eraseToAnyPublisher()
        let sut = GetCoinsListUseCaseImpl(repository: spy)
        var response: CoinsListResponse?
        
        // When
        sut.execute().sink { completion in
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
        XCTAssertEqual(response?.count, 20)
        XCTAssertEqual(response?[0].id ?? "", "01coin")
    }
}
