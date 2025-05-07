//
//  CoinDeskResponse.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/10/22.
//

import Foundation

struct CoinGeckoResponse: Decodable {
    let markets: [Coin]
    
    init() {
        markets = [Coin]()
    }
    
    init(markets: [Coin]) {
        self.markets = markets
    }
}

struct Coin: Decodable, Identifiable {
    let id: String?
    let symbol: String?
    let name: String?
    let image: String?
    let current_price: Double?
    let market_cap: Double?
    let market_cap_rank: Int?
    let total_volume: Double?
    let high_24h: Double?
    let low_24h: Double?
    let price_change_24h: Double?
    let price_change_percentage_24h: Double?
    let market_cap_change_24h: Double?
    let market_cap_change_percentage_24h: Double?
    let circulating_supply: Double?
    let last_updated: String?
    let price_change_percentage_1h_in_currency: Double?
    let price_change_percentage_7d_in_currency: Double?
    
    init() {
        id = ""
        symbol = ""
        name = ""
        image = ""
        current_price = 0.0
        market_cap = 0.0
        market_cap_rank = 0
        total_volume = 0.0
        high_24h = 0.0
        low_24h = 0.0
        price_change_24h = 0.0
        price_change_percentage_24h = 0.0
        market_cap_change_24h = 0.0
        market_cap_change_percentage_24h = 0.0
        circulating_supply = 0.0
        last_updated = ""
        price_change_percentage_1h_in_currency = 0.0
        price_change_percentage_7d_in_currency = 0.0
    }
}

extension DateFormatter {
    func localizedDateString(_ dateString: String) -> String {
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = self.date(from: dateString) ?? Date()
        
        self.dateStyle = .short
        self.timeStyle = .short
        self.locale = Locale.current
        return string(from: date)
    }
}

extension NumberFormatter {
    func localizedCurrencyString(_ number: Double) -> String {
        self.numberStyle = .currency
        self.minimumFractionDigits = 0
        self.maximumFractionDigits = 2
        self.locale = Locale.current
        
        if Locale.current.currencyCode == nil || Locale.current.currencySymbol == nil {
            self.currencyCode = "USD"
            self.currencySymbol = "$"
        }
        
        return string(for: number) ?? String(localized: "nil")
    }
    
    func localizedCurrencyString(_ number: Int) -> String {
        self.numberStyle = .currency
        self.maximumFractionDigits = 0
        self.locale = Locale.current
        
        if Locale.current.currencyCode == nil || Locale.current.currencySymbol == nil {
            self.currencyCode = "USD"
            self.currencySymbol = "$"
        }
        
        return string(for: number) ?? String(localized: "nil")
    }
}
