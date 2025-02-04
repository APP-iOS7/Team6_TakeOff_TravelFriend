//
//  Int+Extension.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//
import Foundation

extension Int {
    var commaSeparatedString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
