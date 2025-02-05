//
//  Untitled.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//
import Foundation
import SwiftData

@Model
class Travel {
    var location: String
    /// 여행 일수
    var period: Int
    var budget: Double
    
    init(location: String = "", period: Int = 1, budget: Double = 0.0) {
        self.location = location
        self.period = period
        self.budget = budget
    }
}
