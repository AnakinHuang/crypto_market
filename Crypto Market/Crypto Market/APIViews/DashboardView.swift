//
//  DashboardView.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/10/22.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var marketsVM: MarketsVM
    
    var body: some View {
        ZStack {
            if marketsVM.showProgress == true || marketsVM.main == nil {
                Spacer()
                
                ProgressView()
                
                Spacer()
            } else {
                CoinView(coin: marketsVM.main ?? Coin())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(marketsVM: MarketsVM())
    }
}
