//
//  NotificationSettingView.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/11/22.
//

import SwiftUI
import AVFoundation

struct NotificationSettingView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("notification") var notification = false
    @AppStorage("sound") var sound: Bool = true
    
    @ObservedObject var notificationMgr = NotificationManager()
    
    @State private var title = ""
    @State private var notes = ""
    @State private var alert = Date()
    
    @FocusState var focus: Bool
    
    var body: some View {
        VStack {
            Form {
                Section("notification") {
                    
                    Toggle("allow_notifications", isOn: $notification)
                        .onChange(of: notification, perform: { _ in
                            withAnimation(Animation.easeInOut(duration: 1)) {
                                if notification {
                                    notificationMgr.requestAuthorization()
                                }
                            }
                        })
                    
                    if notification {
                        DatePicker("Date", selection: $alert)
                            .datePickerStyle(GraphicalDatePickerStyle())
                        
                        TextField("title", text: $title)
                            .textFieldStyle(.roundedBorder)
                            .focused($focus)
                            .padding(.vertical)
                        
                        TextField("notes", text: $notes)
                            .textFieldStyle(.roundedBorder)
                            .focused($focus)
                            .padding(.vertical)
                    }
                }
                
                if notification {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Button(action: {
                            if sound {
                                AudioServicesPlaySystemSound(1022)
                            }
                            notificationMgr.schedule(title: title, notes: notes, date: alert)
                            reset()
                        }) {
                            Label("set", systemImage: "bell.badge")
                                .font(.headline)
                        }
                        .buttonStyle(.borderless)
                        .foregroundColor(title.isEmpty ? .gray : .accentColor)
                        .disabled(title.isEmpty)
                        
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
        .onTapGesture {
            focus = false
        }
    }
    
    func reset() {
        title = ""
        notes = ""
    }
}

struct Notification_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingView()
    }
}
