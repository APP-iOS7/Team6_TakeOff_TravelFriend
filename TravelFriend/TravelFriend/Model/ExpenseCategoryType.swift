//
//  ExpenseCategoryType.swift
//  TravelFriend
//
//  Created by 이재용 on 2/6/25.
//

import Foundation
import SwiftUI

enum ExpenseCategoryType: String, CaseIterable {
    case ticket = "입장료"
    case accommodation = "숙소비"
    case shopping = "쇼핑"
    case transportation = "교통비"
    case food = "식비"
    case entertainment = "문화/공연"
    case souvenir = "기념품"
    
    var icon: String {
        switch self {
        case .ticket: return "🎟️"
        case .accommodation: return "🏨"
        case .shopping: return "🛍️"
        case .transportation: return "🚕"
        case .food: return "🍔"
        case .entertainment: return "🎬"
        case .souvenir: return "🎁"
        }
    }
    
    var color: Color {
        switch self {
        case .ticket:
            return Color.primarySkyblue
        case .accommodation:
            return Color.secondarySkyBlue
        case .shopping:
            return Color.primaryPink
        case .transportation:
            return Color.primaryOrange
        case .food:
            return Color.secondayOrange
        case .entertainment:
            return Color.secondaryPink
        case .souvenir:
            return Color.primaryBlue
        }
    }
    
    static func from(_ typeString: String) -> ExpenseCategoryType? {
        return ExpenseCategoryType.allCases.first { $0.rawValue == typeString }
    }
}
