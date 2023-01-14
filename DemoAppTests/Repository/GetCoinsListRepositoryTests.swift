//
//  GetCoinsListRepositoryTests.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import XCTest
import Combine
import Moya
@testable import DemoApp

final class GetCoinsListRepositoryTests: XCTestCase {
    private var anyCancellable: Set<AnyCancellable> = .init()
    let customEndpointClosure = { (target: CoinsAPI) -> Endpoint in
        Endpoint(url: URL(target: target).absoluteString,
                 sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                 method: target.method,
                 task: target.task,
                 httpHeaderFields: target.headers)
    }
    
    func test_GetCoinsList_ShouldBeSuccess() {
        // Given
        let expectataion = XCTestExpectation(description: "GetCoinsList should be success")
        let provider = MoyaProvider<CoinsAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        let sut = GetCoinsListRepositoryImpl(provider: provider)
        var response: CoinsListResponse?
        
        // When
        sut.getCoinList().sink { completion in
            switch completion {
            case .failure:
                XCTFail()
            default: break
            }
        } receiveValue: { result in
            response = result
            expectataion.fulfill()
        }
        .store(in: &anyCancellable)
        wait(for: [expectataion], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.count, 20)
    }
}
