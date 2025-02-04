//
//  Double+Extension.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import Foundation

extension Double {
    var commaSeparatedString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2 // 소수점 자릿수 조절 가능
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
