//
//  CoinGeckoHelper.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/10/22.
//

import Foundation

enum URLError: Error {
    case BadURL, BadData
}

let CoinGeckoBaseUrl = "https://api.coingecko.com/api/v3/coins/markets"
let page = 1
let price_change_percentage = "1hpercent_sign2C7d"

class CoinGeckoHelper: ObservableObject {
    private func CoinGeckoURL(with parameters: [String:String]) -> URL? {
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        guard var components = URLComponents(string: CoinGeckoBaseUrl) else { return nil }
        components.queryItems = queryItems
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "percent_sign", with: "%")
        return components.url
    }
    
    func fetchMarkets(order: String, per_page: Int) async throws -> CoinGeckoResponse {
        let parameters = [
            "vs_currency": Locale.current.currencyCode?.lowercased() ?? "usd",
            "order": order,
            "per_page": "\(per_page)",
            "page": "\(page)",
            "price_change_percentage": price_change_percentage,
        ]
        
        guard let url = CoinGeckoURL(with: parameters) else { throw URLError.BadURL }
        
        let request = URLRequest(url: url)
        let (data, URLResponse) = try await URLSession.shared.data(for: request)
        guard (URLResponse as? HTTPURLResponse)?.statusCode == 200 else { throw URLError.BadURL }
        
        let decoder = JSONDecoder()
        let markets = try decoder.decode([Coin].self, from: data)
        return CoinGeckoResponse(markets: markets)
    }
}
