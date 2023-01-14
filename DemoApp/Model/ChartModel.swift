//
//  ChartModel.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import Foundation

struct ChartModel: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
    
    public init(date: Date, value: Double) {
        self.date = date
        self.value = value
    }
}
