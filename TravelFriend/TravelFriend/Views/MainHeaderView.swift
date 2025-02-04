//
//  MainHeaderView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI

struct MainHeaderView: View {
    
    private var title: String = "재밌는 여행"
    private var nation: String = "일본"
    private var date: Date = Date()
    private var periodString: String = "5박 6일"
    private var budget: Int = 1000000
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title + " (\(nation))")
            Text("총 예산: \(budget.commaSeparatedString)원")
            Text("기간: \(periodString)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.primarySkyblue)
    }
}

#Preview {
    MainHeaderView()
}
