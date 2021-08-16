//
//  HomeViewModel.swift
//  Tutorial
//
//  Created by Hunter Walker on 8/15/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published  var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }.store(in: &cancellables)
    }
}
