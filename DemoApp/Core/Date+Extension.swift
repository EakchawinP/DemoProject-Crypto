//
//  Date+Extension.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Foundation

extension Date {
    var previousDay: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}
