//
//  AdvancedSettingView.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/11/22.
//

import SwiftUI

struct AdvancedSettingView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("sortBy") var sortBy: SortBy = .market_cap
    @AppStorage("order") var order: Order = .descending
    @AppStorage("per_page") var per_page: Int = 10
    
    var body: some View {
        VStack {
            Form {
                Section("sort") {
                    Picker("Attribute", selection: $sortBy) {
                        ForEach(SortBy.allCases, id: \.self) { attribute in
                            Text(attribute.title())
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Picker("Order", selection: $order) {
                        ForEach(Order.allCases, id: \.self) { attribute in
                            Text(attribute.image())
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("load") {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Picker("Top", selection: $per_page) {
                            ForEach(10...200, id: \.self) {
                                Text("\($0)").tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Spacer()
                    }
                }
            }
            
            HStack(alignment: .center) {
                Spacer()
                
                Button(action: { dismiss() }) {
                    Label("back", systemImage: "arrow.uturn.backward.square")
                        .font(.title2)
                }
                .buttonStyle(.bordered)
                .padding()
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct AdvanceSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedSettingView()
    }
}
