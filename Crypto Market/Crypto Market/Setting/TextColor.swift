//
//  TextColor.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/11/22.
//

import Foundation
import SwiftUI

enum TextColor: Int, CaseIterable {
    case auto, orange, red, blue
    
    func color() -> Color {
        switch self {
        case .auto:
            return Color("TextColor")
        case .red:
            return Color.red
        case .orange:
            return Color.orange
        case .blue:
            return Color.blue
        }
    }
    
    func accentColor() -> Color {
        switch self {
        case .auto:
            return Color.accentColor
        case .red:
            return Color.orange
        case .orange:
            return Color.yellow
        case .blue:
            return Color.cyan
        }
    }
    
    func image() -> LocalizedStringKey {
        switch self {
        case .auto:
            return LocalizedStringKey("auto")
        case .red:
            return LocalizedStringKey("red")
        case .orange:
            return LocalizedStringKey("orange")
        case .blue:
            return LocalizedStringKey("blue")
        }
    }
}
