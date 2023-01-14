//
//  CoinsListResponse.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Foundation

public typealias CoinsListResponse = [CoinsList]

public struct CoinsList: Codable {
    public let id: String?
    public let symbol: String?
    public let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
    }
}
