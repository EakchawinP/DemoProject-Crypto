//
//  CryptoInfoDetailViewModelTests.swift
//  DemoAppTests
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import XCTest
import Combine
import SwiftUI
@testable import DemoApp

final class CryptoInfoDetailViewModelTests: XCTestCase {
    private var anyCancellable: Set<AnyCancellable> = .init()
    private var coinsHistoryReponse: CoinsHistoryResponse!
    private var spy: GetCoinsHistoryRepositorySpy!
    private var sut: CryptoInfoDetailViewModel!
    
    override func setUp() {
        super.setUp()
        coinsHistoryReponse = try! DataMockManager<CoinsHistoryResponse>.get(name: "CoinsHistoryResponse")
        spy = GetCoinsHistoryRepositorySpy()
        spy.stubbedExecuteResult = Just(coinsHistoryReponse).setFailureType(to: Error.self).eraseToAnyPublisher()
        sut = CryptoInfoDetailViewModel(id: "abachi", getCoinsHistoryRepository: spy)
    }
    
    func test_GetCoinValue_ShouldBeSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Publishes state built from received state loaded")
        
        // When
        sut.getCoinValue()
        sut.$state.sink { state in
            if state == .loaded {
                expectation.fulfill()
            }
        }
        .store(in: &anyCancellable)
        
        wait(for: [expectation], timeout: 0.1)
        
        // Then
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertNotNil(sut.itemValueCurrent)
        XCTAssertNotNil(sut.itemValuePrevious)
    }
    
    func test_CalculatePercent_ShouldBeValueNotZero() {
        // Given
        var result: String = ""
        let valueCurrent: Double = 2.30
        let valuePrevious: Double = 2.26
        
        // When
        result = sut.calculatePercent(valueCurrent: valueCurrent, valuePrevious: valuePrevious)
        
        // Then
        XCTAssertEqual(result, "+1.77 %")
    }
    
    func test_CalculatePercent_ShouldBeValueZero() {
        // Given
        var result: String = ""
        let valueCurrent: Double = 0.00
        let valuePrevious: Double = 0.00
        
        // When
        result = sut.calculatePercent(valueCurrent: valueCurrent, valuePrevious: valuePrevious)
        
        // Then
        XCTAssertEqual(result, "N/A")
    }
    
    func test_CalculatePercent_ShouldBeValuePreviousZero() {
        // Given
        var result: String = ""
        let valueCurrent: Double = 0.01
        let valuePrevious: Double = 0.00
        
        // When
        result = sut.calculatePercent(valueCurrent: valueCurrent, valuePrevious: valuePrevious)
        
        // Then
        XCTAssertEqual(result, "+100.00 %")
    }
    
    func test_SetColorText_ShouldBeColorGreen() {
        // Given
        var colorText: Color = .white
        let value: String = "+100.00 %"
        
        // When
        colorText = sut.setColorText(value: value)
        
        // Then
        XCTAssertEqual(colorText, .green)
    }
    
    func test_SetColorText_ShouldBeColorRed() {
        // Given
        var colorText: Color = .white
        let value: String = "-3.25 %"
        
        // When
        colorText = sut.setColorText(value: value)
        
        // Then
        XCTAssertEqual(colorText, .red)
    }
    
    func test_SetColorText_ShouldBeColorBlack() {
        // Given
        var colorText: Color = .white
        let value: String = "N/A"
        
        // When
        colorText = sut.setColorText(value: value)
        
        // Then
        XCTAssertEqual(colorText, .black)
    }
}
