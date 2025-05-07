//
//  MarketsView.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/11/22.
//

import SwiftUI

struct MarketsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("sortBy") var sortBy: SortBy = .market_cap
    @AppStorage("order") var order: Order = .descending
    
    @ObservedObject var marketsVM: MarketsVM
    
    var body: some View {
        NavigationView {
            ZStack {
                if marketsVM.showProgress == true {
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                } else {
                    List {
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Text(sortBy.sortBy(by: order))
                                .font(.headline)
                            
                            Spacer()
                        }
                        
                        ForEach(marketsVM.publishedResponse?.markets ?? [Coin]()) { coin in
                            NavigationLink {
                                DetailView(coin: coin)
                            } label: {
                                HStack(alignment: .center) {
                                    AsyncImage(
                                        url: URL(string: coin.image ?? ""),
                                        content: { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 48, height: 48, alignment: .center)
                                        }, placeholder: {
                                            ProgressView()
                                                .frame(width: 48, height: 48, alignment: .center)
                                                .overlay(RoundedRectangle(cornerRadius: 12.0).stroke(Color.accentColor, lineWidth: 1))
                                        }
                                    )
                                    
                                    VStack(alignment: .leading) {
                                        Text(coin.name ?? "nil")
                                            .font(.title2)
                                            .lineLimit(1)
                                        
                                        Text(NumberFormatter().localizedCurrencyString(coin.current_price ?? 0.0))
                                            .font(.headline)
                                            .foregroundColor(MarketsVM.priceColor(coin.price_change_percentage_24h ?? 0.0))
                                    }
                                    
                                    Spacer()
                                    
                                    Divider()
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(NumberFormatter().localizedCurrencyString(coin.price_change_24h ?? 0.0))
                                            
                                            Text(String(format: "%.2f", coin.price_change_percentage_24h ?? 0.0) + "%")
                                        }
                                        .foregroundColor(MarketsVM.priceColor(coin.price_change_percentage_24h ?? 0.0))
                                        
                                        HStack {
                                            Text("h:")
                                            
                                            Text(NumberFormatter().localizedCurrencyString(coin.high_24h ?? 0.0))
                                                .foregroundColor(.red)
                                        }
                                        
                                        HStack {
                                            Text("l:")
                                            
                                            Text(NumberFormatter().localizedCurrencyString(coin.low_24h ?? 0.0))
                                                .foregroundColor(.green)
                                        }
                                    }
                                    .font(.caption2)
                                }
                                .padding(.vertical)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(LocalizedStringKey("top \(String(marketsVM.per_page))"), displayMode: .inline)
        }
    }
}

struct MarketsView_Previews: PreviewProvider {
    static var previews: some View {
        MarketsView(marketsVM: MarketsVM())
    }
}
