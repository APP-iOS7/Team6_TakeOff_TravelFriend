//
//  MainView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI

struct MainView: View {
    @State private var shouldRefresh = false
    @Binding var shouldRefreshMain: Bool  // 추가
    
    var body: some View {
        VStack {
            MainHeaderView(shouldRefresh: $shouldRefresh)
            MainChartView(dailyExpenses: [])
        }
        .onChange(of: shouldRefresh) { _ in
                    // 필요한 갱신 로직
            print("화면 갱신..")
            shouldRefreshMain.toggle()
        }
    }
}

#Preview {
    MainView(shouldRefreshMain: .constant(false))
}
