//
//  SortBy.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/10/22.
//

import Foundation
import SwiftUI

enum Order: Int, CaseIterable {
    case descending, ascending
    
    func title() -> LocalizedStringKey {
        switch self {
        case .descending:
            return LocalizedStringKey("descending")
        case .ascending:
            return LocalizedStringKey("ascending")
        }
    }
    
    func image() -> LocalizedStringKey {
        switch self {
        case .descending:
            return LocalizedStringKey("des_img")
        case .ascending:
            return LocalizedStringKey("asc_img")
        }
    }
}

enum SortBy: Int, CaseIterable {
    case market_cap, volume, id
    
    func order(by: Order) -> String {
        switch by {
        case .descending:
            switch self {
            case .market_cap:
                return "market_cap_desc"
            case .volume:
                return "volume_desc"
            case .id:
                return "id_desc"
            }
        case .ascending:
            switch self {
            case .market_cap:
                return "market_cap_asc"
            case .volume:
                return "volume_asc"
            case .id:
                return "id_asc"
            }
        }
    }
    
    func sortBy(by: Order) -> LocalizedStringKey {
        switch by {
        case .descending:
            switch self {
            case .market_cap:
                return LocalizedStringKey("sort_MC_des")
            case .volume:
                return LocalizedStringKey("sort_vol_des")
            case .id:
                return LocalizedStringKey("sort_id_des")
            }
        case .ascending:
            switch self {
            case .market_cap:
                return LocalizedStringKey("sort_MC_asc")
            case .volume:
                return LocalizedStringKey("sort_vol_asc")
            case .id:
                return LocalizedStringKey("sort_id_asc")
            }
        }
    }
    
    func title() -> LocalizedStringKey {
        switch self {
        case .market_cap:
            return LocalizedStringKey("market_cap")
        case .volume:
            return LocalizedStringKey("volume")
        case .id:
            return LocalizedStringKey("id")
        }
    }
}
