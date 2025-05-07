//
//  ContentView.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/10/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @AppStorage("colorScheme") var colorScheme: Appearance = .auto
    @AppStorage("textColor") var textColor: TextColor = .auto
    @AppStorage("sound") var sound: Bool = true
    
    @StateObject var marketsVM = MarketsVM()
    
    @State var currentTab = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                DashboardView(marketsVM: marketsVM)
                    .tabItem({
                        Label(TabType.dashboard.title(), systemImage: TabType.dashboard.image())
                    })
                    .tag(0)
                
                MarketsView(marketsVM: marketsVM)
                    .tabItem({
                        Label(TabType.markets.title(), systemImage: TabType.markets.image())
                    })
                    .tag(1)
                
                SettingView(marketsVM: marketsVM)
                    .tabItem({
                        Label(TabType.settings.title(), systemImage: TabType.settings.image())
                    })
                    .tag(2)
                
                InfoView()
                    .tabItem({
                        Label(TabType.info.title(), systemImage: TabType.info.image())
                    })
                    .tag(3)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            if sound {
                                AudioServicesPlaySystemSound(1033)
                            }
                            getMarkets()
                        }
                    }, label: {
                        Label("Refresh", systemImage: "gobackward")
                            .rotationEffect(.degrees(marketsVM.showProgress ? 90 : 0))
                            .scaleEffect(marketsVM.showProgress ? 1.5 : 1)
                            .disabled(currentTab < 2)
                            .opacity(currentTab < 2 ? 1.0 : 0.0)
                    })
                }
            }
            .onAppear() { getMarkets() }
            .navigationBarTitle(LocalizedStringKey("update \(DateFormatter().localizedDateString(marketsVM.main?.last_updated ?? ""))"), displayMode: .inline)
            .navigationBarHidden(currentTab > 1 ? true : false)
        }
        .foregroundColor(textColor.color())
        .accentColor(textColor.accentColor())
        .preferredColorScheme(colorScheme.scheme())
    }
    
    func getMarkets() {
        Task {
            marketsVM.showProgress = true
            
            await marketsVM.update()
            
            marketsVM.showProgress = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
