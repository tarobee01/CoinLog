//
//  ViewModel.swift
//  NetworkingPractice
//
//  Created by 武林慎太郎 on 2024/01/28.
//

import Foundation

@Observable
class ViewModel {
    var ping = ""
    var services = Services()
    var coins = [Coin]()
    
    init(pair: String) {
        Task {
                self.coins = await fetchCoins(pair: pair)
        }
    }
    
    func fetchPing() {
        services.fetchPing { [weak self] fromServices in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.ping = fromServices
            }
        }
    }
    
    func fetchCoins(pair: String) async -> [Coin]{
        let coins = await services.fetchCoins(pair: pair)
        return coins
    }
}
