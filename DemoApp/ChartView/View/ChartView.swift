//
//  ChartView.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import SwiftUI
import Charts

struct ChartView: View {
    private var title: String
    private var coinsValueCurrent: Double
    private var coinsValuePrevious: Double
    private var itemList: [ChartModel] = []
    private var isColorLine: Color = .blue
    
    public init(title: String, coinsValueCurrent: Double, coinsValuePrevious: Double) {
        self.title = title
        self.coinsValueCurrent = coinsValueCurrent
        self.coinsValuePrevious = coinsValuePrevious
        self.itemList = [ChartModel(date: Date().previousDay, value: coinsValuePrevious),
                         ChartModel(date: Date(), value: coinsValueCurrent)]
        self.isColorLine = coinsValueCurrent > coinsValuePrevious ? .green : .red
    }

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 24))
                    .bold()
                    .lineLimit(1)
                Spacer()
            }
            .padding(.bottom, 20)
            
            Chart {
                ForEach(itemList) { item in
                    LineMark(x: .value("Day", item.date),
                             y: .value("value", item.value))
                    .foregroundStyle(setColotLine(coinsValueCurrent: coinsValueCurrent, coinsValuePrevious: coinsValuePrevious))
                }
            }
            .frame(height: 300)
            
            
        }
        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
    }
    
    private func setColotLine(coinsValueCurrent: Double, coinsValuePrevious: Double) -> Color {
        if coinsValueCurrent > coinsValuePrevious {
            return .green
        } else if coinsValueCurrent < coinsValuePrevious {
            return .red
        } else {
            return .blue
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(title: "Coins",coinsValueCurrent: 0.10, coinsValuePrevious: 0.10)
    }
}
