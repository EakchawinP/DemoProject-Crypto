//
//  Double+Extension.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
