//
//  Crypto_MarketApp.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/10/22.
//

import SwiftUI

@main
struct Crypto_MarketApp: App {
    @AppStorage("language") var language: Language = .system
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: language.code()))
        }
    }
}
