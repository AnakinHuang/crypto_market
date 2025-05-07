//
//  MarketsVM.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/10/22.
//

import Foundation
import SwiftUI

class MarketsVM: ObservableObject {
    @AppStorage("symbol") var symbol: String = "btc"
    @AppStorage("sortBy") var sortBy: SortBy = .market_cap
    @AppStorage("order") var order: Order = .descending
    @AppStorage("per_page") var per_page: Int = 10
    
    @Published var publishedResponse: CoinGeckoResponse?
    @Published var main: Coin?
    @Published var showProgress: Bool = false
    
    private let helper = CoinGeckoHelper()
    private var response: CoinGeckoResponse? = nil
    
    func currentMain() -> Coin {
        if let markets = publishedResponse?.markets {
            let current = markets.filter { $0.symbol == symbol }
            
            if current.isEmpty {
                symbol = markets[0].symbol ?? "btc"
                return markets[0]
            }
            
            return current[0]
        }
        
        return Coin()
    }
    
    func update() async {
        do {
            response = try await helper.fetchMarkets(order: sortBy.order(by: order), per_page: per_page)
            await MainActor.run {
                publishedResponse = nil
                publishedResponse = response
                main = currentMain()
            }
        } catch { print(error) }
    }
    
    static func priceColor(_ price_change_percentage: Double) -> Color {
        switch price_change_percentage {
        case 0.0:
            return .accentColor
        case ..<0.0:
            return .green
        default:
            return .red
        }
    }
}

