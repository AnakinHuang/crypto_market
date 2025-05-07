//
//  Language.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 9/8/23.
//

import Foundation
import SwiftUI

enum Language: Int, CaseIterable {
    case system, english, chinese, german
    
    func code() -> String {
        switch self {
        case .system:
            return Locale.current.languageCode ?? "en"
        case .english:
            return "en"
        case .chinese:
            return "zh"
        case .german:
            return "de"
        }
    }
    
    func image() -> LocalizedStringKey {
        switch self {
        case .system:
            return LocalizedStringKey("system")
        case .english:
            return LocalizedStringKey("english")
        case .chinese:
            return LocalizedStringKey("chinese")
        case .german:
            return LocalizedStringKey("german")
        }
    }
    
    static func raw(code: String) -> Language {
        switch code {
        case "zh":
            return .chinese
        case "de":
            return .german
        default:
            return .english
        }
    }
}
