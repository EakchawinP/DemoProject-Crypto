//
//  CryptoInfoDetailView.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import SwiftUI

struct CryptoInfoDetailView: View {
    @ObservedObject var viewModel: CryptoInfoDetailViewModel
    public var title: String
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    public init(title: String, viewModel: CryptoInfoDetailViewModel) {
        self.title = title
        self.viewModel = viewModel
    }
                
    var body: some View {
        
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.getCoinValue)
        case .loading:
            Text("Loading...")
        case .failed:
            Text("... Error Page ...")
                .font(.system(size: 32))
                .lineLimit(1)
        case .loaded:
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    // currentPrice
                    HStack(spacing: 0) {
                        VStack {
                            NavigationLink(destination: ChartView(title: "\(title): Price", coinsValueCurrent: viewModel.itemValueCurrent?.currentPrice?.value?.rounded(toPlaces: 2) ?? 0, coinsValuePrevious: viewModel.itemValuePrevious?.currentPrice?.value?.rounded(toPlaces: 2) ?? 0)) {
                                HStack {
                                    Spacer()
                                    Text("Price Chart >>>")
                                }
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                            }
                            getView(title: "Price", valueCurrent: viewModel.itemValueCurrent?.currentPrice?.value ?? 0, valuePrevious: viewModel.itemValuePrevious?.currentPrice?.value ?? 0)
                        }
                    }
                    .padding(.bottom, 5)
                    
                    Divider()
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    
                    // marketCap
                    HStack(spacing: 0) {
                        VStack {
                            NavigationLink(destination: ChartView(title: "\(title): Market Cap", coinsValueCurrent: viewModel.itemValueCurrent?.marketCap?.value?.rounded(toPlaces: 2) ?? 0, coinsValuePrevious: viewModel.itemValuePrevious?.marketCap?.value?.rounded(toPlaces: 2) ?? 0)) {
                                HStack {
                                    Spacer()
                                    Text("Market Cap Chart >>>")
                                }
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                            }
                            getView(title: "Market Cap", valueCurrent: viewModel.itemValueCurrent?.marketCap?.value ?? 0, valuePrevious: viewModel.itemValuePrevious?.marketCap?.value ?? 0)
                        }
                    }
                    .padding(.bottom, 5)
                    
                    Divider()
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    
                    // totalVolume
                    HStack(spacing: 0) {
                        VStack {
                            NavigationLink(destination: ChartView(title: "\(title): Volume", coinsValueCurrent: viewModel.itemValueCurrent?.totalVolume?.value?.rounded(toPlaces: 2) ?? 0, coinsValuePrevious: viewModel.itemValuePrevious?.totalVolume?.value?.rounded(toPlaces: 2) ?? 0)) {
                                HStack {
                                    Spacer()
                                    Text("Volume Chart >>>")
                                }
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                            }
                            getView(title: "Volume", valueCurrent: viewModel.itemValueCurrent?.totalVolume?.value ?? 0, valuePrevious: viewModel.itemValuePrevious?.totalVolume?.value ?? 0)
                        }
                    }
                    
                    Spacer()
                }
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .padding(.top, 35)
            }
        }
        
    }
}

extension CryptoInfoDetailView {
    func getView(title: String, valueCurrent: Double, valuePrevious: Double) -> AnyView {
        let valueChange = viewModel.calculatePercent(valueCurrent: valueCurrent, valuePrevious: valuePrevious)
        return AnyView(
            LazyVGrid(columns: columns, spacing: 0) {
                VStack(spacing: 0) {
                    Text("Prev. \(title)")
                        .bold()
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .padding(.bottom, 5)
                    Text("\(String(format: "%.2f", valuePrevious)) $")
                        .font(.system(size: 14))
                        .lineLimit(1)
                }
                
                VStack(spacing: 0) {
                    Text("\(title)")
                        .bold()
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .padding(.bottom, 5)
                    Text("\(String(format: "%.2f", valueCurrent)) $")
                        .font(.system(size: 14))
                        .lineLimit(1)
                }
                
                VStack(spacing: 0) {
                    Text("% Change")
                        .bold()
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .padding(.bottom, 5)
                    Text("\(valueChange)")
                        .font(.system(size: 14))
                        .lineLimit(1)
                        .foregroundColor(viewModel.setColorText(value: valueChange))
                }
            }
            .padding(.horizontal)
        )
    }
}
