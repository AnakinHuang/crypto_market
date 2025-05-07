//
//  CoinView.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/11/22.
//

import SwiftUI

struct CoinView: View {
    @ObservedObject var soundMgr = SoundManager()
    
    @State private var showButton = true
    @State private var showDetails = false
    @State private var rotate = false
    @State var coin: Coin
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            AsyncImage(
                url: URL(string: coin.image ?? ""),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 96, height: 96, alignment: .center)
                }, placeholder: {
                    ProgressView()
                        .frame(width: 96, height: 96, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 24.0).stroke(Color.accentColor, lineWidth: 2))
                }
            )
            .rotation3DEffect(Angle(degrees: rotate ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            .animation(.easeInOut(duration: 0.3), value: rotate)
            .onTapGesture {
                withAnimation {
                    soundMgr.playSound()
                    rotate.toggle()
                }
            }
            .padding()
            
            Text(coin.name ?? "nil")
                .font(.largeTitle)
            
            List {
                HStack(alignment: .center) {
                    Spacer()
                    
                    VStack {
                        Group {
                            Text(NumberFormatter().localizedCurrencyString(coin.current_price ?? 0.0))
                                .font(.largeTitle)
                            
                            HStack {
                                Text(NumberFormatter().localizedCurrencyString(coin.price_change_24h ?? 0.0))
                                
                                Text(String(format: "%.2f", coin.price_change_percentage_24h ?? 0.0) + "%")
                            }
                            .font(.callout)
                        }
                        .foregroundColor(MarketsVM.priceColor(coin.price_change_percentage_24h ?? 0.0))
                        
                        Group {
                            Button(action: {
                                withAnimation {
                                    showDetails.toggle()
                                }
                            }, label: {
                                Text("press")
                                    .opacity(showButton ? 1.0 : 0.0)
                            })
                            .onAppear {
                                withAnimation(.spring().speed(0.25).repeatForever(autoreverses: true)) {
                                    showButton.toggle()
                                }
                            }
                            
                            if showDetails {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("1h")
                                        
                                        Text("7d")
                                    }
                                    
                                    VStack(alignment: .trailing) {
                                        Text(String(format: "%.2f", coin.price_change_percentage_1h_in_currency ?? 0.0) + "%")
                                        
                                        Text(String(format: "%.2f", coin.price_change_percentage_7d_in_currency ?? 0.0) + "%")
                                    }
                                    .foregroundColor(MarketsVM.priceColor(coin.price_change_percentage_24h ?? 0.0))
                                }
                                .transition(.scale)
                            }
                        }
                        .font(.footnote)
                    }
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
                .padding(.top)
                
                Divider()
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("high")
                        
                        Text("low")
                    }
                    
                    VStack(alignment: .leading) {
                        Text(NumberFormatter().localizedCurrencyString(coin.high_24h ?? 0.0))
                            .foregroundColor(.red)
                        
                        Text(NumberFormatter().localizedCurrencyString(coin.low_24h ?? 0.0))
                            .foregroundColor(.green)
                    }
                    .padding(.trailing)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("vol.")
                        
                        Text("cs.")
                    }
                    .padding(.leading)
                    
                    VStack(alignment: .leading) {
                        Text(NumberFormatter().localizedCurrencyString(coin.total_volume ?? 0.0))
                        
                        Text(NumberFormatter().localizedCurrencyString(coin.circulating_supply ?? 0.0))
                    }
                    
                    Spacer()
                }
                .font(.footnote)
                .listRowSeparator(.hidden)
                .padding(.bottom)
                
                Divider()
                
                HStack(alignment: .center) {
                    Spacer ()
                    
                    VStack {
                        HStack {
                            Text("MC")
                            
                            Text(NumberFormatter().localizedCurrencyString(coin.market_cap ?? 0.0))
                                .foregroundColor(MarketsVM.priceColor(coin.market_cap_change_percentage_24h ?? 0.0))
                        }
                        .font(.headline)
                        
                        HStack {
                            Text(NumberFormatter().localizedCurrencyString(coin.market_cap_change_24h ?? 0.0))
                            
                            Text(String(format: "%.2f", coin.market_cap_change_percentage_24h ?? 0.0) + "%")
                        }
                        .font(.footnote)
                        .foregroundColor(MarketsVM.priceColor(coin.market_cap_change_percentage_24h ?? 0.0))
                    }
                    
                    Spacer ()
                }
                .listRowSeparator(.hidden)
                .padding(.bottom)
            }
        }
    }
}

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    var coin: Coin
    
    var body: some View {
        VStack {
            CoinView(coin: coin)
            
            Spacer()
            
            Button(action: { dismiss() }) {
                Label("back", systemImage: "arrow.uturn.backward.square")
                    .font(.title2)
            }
            .buttonStyle(.bordered)
            .padding()
        }
        .navigationBarHidden(true)
    }
}


struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinView(coin: Coin())
            
            DetailView(coin: Coin())
        }
    }
}
