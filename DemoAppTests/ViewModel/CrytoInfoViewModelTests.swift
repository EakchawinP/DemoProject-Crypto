//
//  CrytoInfoViewModelTests.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import XCTest
import Combine
@testable import DemoApp

final class CrytoInfoViewModelTests: XCTestCase {
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    func test_GetDataCrypto_ShouldBeSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "GetDataCrypto should be success")
        let coinsListReponse = try! DataMockManager<CoinsListResponse>.get(name: "CoinsListResponse")
        let spy = GetCoinsListUseCaseSpy()
        spy.stubbedGetCoinsListResult = Just(coinsListReponse).setFailureType(to: Error.self).eraseToAnyPublisher()
        let sut = CrytoInfoViewModel(getCoinsListUseCase: spy)
        
        // When
        sut.getDataCrypto()
        
        // Then
        XCTAssertEqual(spy.invokedGetCoinsListCount, 1)
        XCTAssertEqual(sut.state, .loaded)
    }
}
