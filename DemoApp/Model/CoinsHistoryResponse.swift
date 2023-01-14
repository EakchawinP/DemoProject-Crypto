//
//  CoinsHistoryResponse.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Foundation

public struct CoinsHistoryResponse: Codable {
    public let id: String?
    public let symbol: String?
    public let name: String?
    public let marketData: MarketDataResponse?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case marketData = "market_data"
    }
}

public struct MarketDataResponse: Codable {
    public let currentPrice: CoinValue?
    public let marketCap: CoinValue?
    public let totalVolume: CoinValue?
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
    }
}

public struct CoinValue: Codable {
    public let value: Double?
    
    enum CodingKeys: String, CodingKey {
        case value = "usd"
    }
}
