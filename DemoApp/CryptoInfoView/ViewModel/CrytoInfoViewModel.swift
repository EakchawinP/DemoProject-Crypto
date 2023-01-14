//
//  CrytoInfoViewModel.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 12/1/2566 BE.
//

import Foundation
import Combine

public class CrytoInfoViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
        case failed
    }
    
    public var getCoinsListUseCase: GetCoinsListUseCase
    private var anyCancellable: Set<AnyCancellable> = .init()
    @Published public var itemList: [CoinsList] = []
    @Published var state: State = .idle

    public init(getCoinsListUseCase: GetCoinsListUseCase = GetCoinsListUseCaseImpl()) {
        self.getCoinsListUseCase = getCoinsListUseCase
    }
    
    public func getDataCrypto() {
        state = .loading
        getCoinsListUseCase.execute().sink { completion in
            switch completion {
            case .finished: break
            case let .failure(err):
                self.state = .failed
                print(err)
            }
        } receiveValue: { [weak self] response in
            guard let self = self else { return }
            self.itemList = response
            self.state = .loaded
        }
        .store(in: &anyCancellable)
    }
    
}
