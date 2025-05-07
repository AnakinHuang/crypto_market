//
//  NotificationMgr.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/12/22.
//

import Foundation
import SwiftUI

class NotificationManager: ObservableObject {
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if !success && error == nil {
                print("Notification not permitted")
            }
        }
    }
    
    func schedule(title: String, notes: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = String(localized: "reminder: \(title)")
        content.body = notes
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "Crypto Market Notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
