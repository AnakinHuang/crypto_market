//
//  Appearance.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/11/22.
//

import Foundation
import SwiftUI

enum Appearance: Int, CaseIterable {
    case auto, light, dark
    
    func image() -> Image {
        switch self {
        case .auto:
            return Image(systemName: "gearshape.circle.fill")
        case .light:
            return Image(systemName: "sun.max.fill")
        case .dark:
            return Image(systemName: "moon.fill")
        }
    }
    
    func scheme() -> ColorScheme? {
        switch self {
        case .auto:
            return nil
        case .light:
            return ColorScheme.light
        case .dark:
            return ColorScheme.dark
        }
    }
}
