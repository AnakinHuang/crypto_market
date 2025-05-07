//
//  SettingView.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/11/22.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("symbol") var symbol: String = "btc"
    @AppStorage("sortBy") var sortBy: SortBy = .market_cap
    @AppStorage("order") var order: Order = .descending
    @AppStorage("per_page") var per_page: Int = 10
    @AppStorage("colorScheme") var colorScheme: Appearance = .auto
    @AppStorage("textColor") var textColor: TextColor = .auto
    @AppStorage("language") var language: Language = .system
    @AppStorage("notification") var notification = false
    @AppStorage("sound") var sound: Bool = true
    
    @ObservedObject var marketsVM: MarketsVM
    
    @State private var resetAllAlertPresenting = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("dashboard") {
                    Picker("Default", selection: $symbol) {
                        ForEach(marketsVM.publishedResponse?.markets ?? [Coin]()) { coin in
                            Text(coin.name ?? "nil").tag(coin.symbol ?? "btc")
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section("appearance") {
                    Picker("Scheme", selection: $colorScheme) {
                        ForEach(Appearance.allCases, id: \.self) { scheme in
                            scheme.image()
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("text") {
                    Picker("Color", selection: $textColor) {
                        ForEach(TextColor.allCases, id: \.self) { color in
                            Text(color.image())
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("language") {
                    Picker("Language", selection: $language) {
                        ForEach(Language.allCases, id: \.self) { language in
                            Text(language.image())
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("sound") {
                    Toggle("allow_sound", isOn: $sound)
                }
                
                Section("advanced") {
                    NavigationLink {
                        NotificationSettingView()
                    } label: {
                        Label("notification", systemImage: "bell.circle.fill")
                    }
                    
                    NavigationLink {
                        AdvancedSettingView()
                    } label: {
                        Label("market_list", systemImage: "list.number")
                    }
                }
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button(action: {
                        resetAllAlertPresenting = true
                    }) {
                        Label("reset", systemImage: "arrow.triangle.2.circlepath.circle.fill")
                            .font(.headline)
                    }
                    
                    Spacer()
                }
            }
            .onChange(of: symbol, perform: { _ in
                getMarkets()
            })
            .onChange(of: sortBy, perform: { _ in
                getMarkets()
            })
            .onChange(of: order, perform: { _ in
                getMarkets()
            })
            .onChange(of: per_page, perform: { _ in
                getMarkets()
            })
            .alert("alert", isPresented: $resetAllAlertPresenting) {
                Button("cancel", role: .cancel) { }
                Button("ok", role: .destructive) {
                    reset()
                }
            }
            .navigationBarTitle("settings", displayMode: .inline)
        }
    }
    
    func getMarkets() {
        Task {
            marketsVM.showProgress = true
            
            await marketsVM.update()
            
            marketsVM.showProgress = false
        }
    }
    
    func reset() {
        symbol = "btc"
        sortBy = .market_cap
        order = .descending
        per_page = 10
        colorScheme = .auto
        textColor = .auto
        language = .system
        notification = false
        sound = true
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(marketsVM: MarketsVM())
    }
}
