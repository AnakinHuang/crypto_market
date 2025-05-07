//
//  InfoView.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/11/22.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.openURL) var openURL
    
    @AppStorage("textColor") var textColor: TextColor = .auto
    
    @ObservedObject var soundMgr = SoundManager()
    
    @State private var linkAlertPresenting = false
    @State private var rotate = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                
                Image("AppIconImg")
                    .resizable()
                    .frame(width: 64, height: 64, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 12.0).stroke(textColor.color(), lineWidth: 1))
                    .rotation3DEffect(Angle(degrees: rotate ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                    .animation(.easeInOut(duration: 0.3), value: rotate)
                    .onTapGesture {
                        withAnimation {
                            soundMgr.playSound()
                            rotate.toggle()
                        }
                    }
                    .padding()
                
                Text(LocalizedStringKey(Bundle.main.displayName  ?? "Crypto Market"))
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding()
                
                Text(LocalizedStringKey("version \(Bundle.main.version ?? "")"))
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text(LocalizedStringKey("build \(Bundle.main.build ?? "")"))
                    .font(.caption)
                
                Button(action: {
                    linkAlertPresenting = true
                }, label: {
                    Text("api")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                })
                .padding()
                
                Spacer()
                
                Text(LocalizedStringKey(Bundle.main.copyright ?? ""))
                    .font(.caption2)
            }
            .actionSheet(isPresented: $linkAlertPresenting) {
                ActionSheet(
                    title: Text("action_sheet"),
                    buttons: [
                        .default(Text("no")),
                        .destructive(Text("yes")) {
                            if let url = URL(string: "https://www.coingecko.com/en/api/documentation") {
                                openURL(url)
                            }
                        }
                    ])
                
            }
            .navigationBarTitle("info", displayMode: .inline)
            .padding()
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
