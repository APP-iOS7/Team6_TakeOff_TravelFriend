//
//  DailyExpense.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//
//  지출 모델

import Foundation
import SwiftData

@Model
class DailyExpense: Hashable {
    var id: UUID
    var day: Int
    var category: String
    var price: Double
    
    init(day: Int, category: String, price: Double) {
        self.id = UUID() // 고유 ID 생성
        self.day = day
        self.category = category
        self.price = price
    }
}
