//
//  CryptoInfoDetailViewModel.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Foundation
import Combine
import SwiftUI

public class CryptoInfoDetailViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case failed
    }
    
    public var id: String
    @Published var state: State = .idle
    public var getCoinsHistoryRepository: GetCoinsHistoryRepository
    private var anyCancellable: Set<AnyCancellable> = .init()
    private var date: Date = Date()
    
    public var itemValueCurrent: MarketDataResponse?
    public var itemValuePrevious: MarketDataResponse?
    
    public init(id: String, getCoinsHistoryRepository: GetCoinsHistoryRepository = GetCoinsHistoryRepositoryImpl()) {
        self.id = id
        self.getCoinsHistoryRepository = getCoinsHistoryRepository
    }
    
    public func getCoinValue() {
        state = .loading
        getCoinsHistoryRepository.getCoinHistory(id: id, date: convertDateFormatter(date: date))
            .sink { completion in
                switch completion {
                case .finished: break
                case let .failure(err):
                    print(err)
                }
            } receiveValue: { [weak self] response in
                guard let self = self, response.marketData != nil else {
                    let mapData = MarketDataResponse(currentPrice: nil, marketCap: nil, totalVolume: nil)
                    self?.setItemValue(response: mapData)
                    return
                }
                
                self.setItemValue(response: response.marketData)
            }
            .store(in: &anyCancellable)
        
    }
    
    private func setItemValue(response: MarketDataResponse?) {
        if convertDateFormatter(date: date) == convertDateFormatter(date: Date()) {
            itemValueCurrent = response
            date = Date().previousDay
            getCoinValue()
        } else {
            itemValuePrevious = response
            state = .loaded
        }
    }
    
    public func calculatePercent(valueCurrent: Double, valuePrevious: Double) -> String {
        let current = valueCurrent.rounded(toPlaces: 2)
        let previous = valuePrevious.rounded(toPlaces: 2)
        
        if previous > 0 {
            let result = ((current - previous) / previous) * 100
            let textPlus = result >= 0 ? "+" : ""
            return result.isNaN ? "N/A" : "\(textPlus)\(String(format: "%.2f", result)) %"
        } else {
            guard current > previous else { return "N/A" }
            return "+100.00 %"
        }
    }
    
    public func setColorText(value: String) -> Color {
        if value == "N/A" {
            return Color.black
        } else {
            let replaced = value.replacingOccurrences(of: " %", with: "")
            return Double(replaced) ?? 0 < 0 ? Color.red : Color.green
        }
    }
    
    private func convertDateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        return result
    }
}
