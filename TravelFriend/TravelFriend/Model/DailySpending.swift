//
//  DailySpending.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//
import Foundation
import SwiftData

@Model
class DailySpending {
    var day: Int
    var category: String
    var price: Double
    
    init(day: Int, category: String, price: Double) {
        self.day = day
        self.category = category
        self.price = price
    }
}
