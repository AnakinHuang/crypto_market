//
//  Tabtype.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/11/22.
//

import Foundation
import SwiftUI

enum TabType: Int, CaseIterable {
    case dashboard, markets, settings, info
    
    func title() -> LocalizedStringKey {
        switch self {
        case .dashboard:
            return LocalizedStringKey("dashboard")
        case .markets:
            return LocalizedStringKey("markets")
        case .settings:
            return LocalizedStringKey("settings")
        case .info:
            return LocalizedStringKey("info")
        }
    }
    
    func image() -> String {
        switch self {
        case .dashboard:
            return "person.fill"
        case .markets:
            return "list.bullet.circle.fill"
        case .settings:
            return "gearshape.fill"
        case .info:
            return "questionmark.app.fill"
        }
    }
}
