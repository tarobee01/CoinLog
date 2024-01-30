//
//  ContentView.swift
//  NetworkingPractice
//
//  Created by 武林慎太郎 on 2024/01/28.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State private var viewModel = ViewModel(pair: "btc_jpy")
    @State private var selectedPair: String
    
    let pairs = ["btc_jpy", "etc_jpy", "lsk_jpy", "mona_jpy", "plt_jpy", "fnct_jpy", "dai_jpy", "wbtc_jpy"]
    
    init() {
        self.selectedPair = "btc_jpy"
    }

    var body: some View {
        NavigationStack {
            List {
                Chart(viewModel.coins) { coin in
                    BarMark(
                        x: .value("data", coin.createdAt),
                        y: .value("amount", coin.rate))
                }
                
                ForEach(viewModel.coins) {
                    coin in
                    VStack {
                        HStack(spacing: 10) {
                            if let newDate = coin.formattedDateString {
                                Text(newDate)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity)
                                
                            } else {
                                Text("non date")
                                    .frame(maxWidth: .infinity)
                                
                            }
                            VStack(alignment: .leading, spacing: 6) {
                                Text(coin.pair.uppercased())
                                    .fontWeight(.semibold)
                                Text("\(coin.rate)yen")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .font(.footnote)
                        .padding(2)
                    }
                }
            }
            .navigationTitle("CoinLog")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    VStack {
                        Spacer()
                        Spacer()
                        Picker("", selection: $selectedPair) {
                            ForEach(pairs, id: \.self) {
                                pair in
                                Text("Change to... \(pair.uppercased())")
                            }
                        }
                        .frame(width: 220)
                        Button("change") {
                            Task {
                                viewModel.coins = await viewModel.fetchCoins(pair: selectedPair)
                            }
                        }
                        .background(.orange)
                        .opacity(0.8)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }
            }
        }

    }
        
}

#Preview {
    ContentView()
}
