//
//  CrytoInfoView.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 12/1/2566 BE.
//

import SwiftUI

struct CrytoInfoView: View {
    @ObservedObject var viewModel: CrytoInfoViewModel
    @State private var searchText: String = ""
    @State private var filterWord: [CoinsList] = []
    
    public init(viewModel: CrytoInfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear(perform: viewModel.getDataCrypto)
            case .loading:
                Text("Loading...")
            case .failed:
                Text("... Error Page ...")
                    .font(.system(size: 32))
                    .lineLimit(1)
            case .loaded:
                NavigationStack {
                    List(0 ..< filterWord.count, id: \.self) { index in
                        let item = filterWord[index]
                        NavigationLink(destination: CryptoInfoDetailView(title: item.name ?? "",viewModel: CryptoInfoDetailViewModel(id: item.id ?? ""))) {
                            Text(item.name ?? "")
                                .lineLimit(1)
                        }
                    }
                    .searchable(text: $searchText)
                    .onChange(of: searchText) { search in
                        filterWord = viewModel.itemList.filter { $0.name!.lowercased().starts(with: search.lowercased()) }
                    }
                    .onAppear {
                        filterWord = filterWord.isEmpty ? viewModel.itemList : filterWord
                    }
                }
            }
        }
        .navigationTitle("Cryto Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CrytoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CrytoInfoView(viewModel: CrytoInfoViewModel())
    }
}
