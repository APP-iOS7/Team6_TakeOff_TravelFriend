//
//  MainHeaderView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI

struct MainHeaderView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var dbManager: DBManager?
    @State private var travelItem: Travel?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("여행지: \(travelItem?.location ?? "NONE")")
            Text("총 예산: \(travelItem?.budget.commaSeparatedString ?? "0.0")원")
            Text("기간: \(travelItem?.period ?? 0)일")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.primarySkyblue)
        .onAppear() {
            fetchTravelData()
        }
    }
    
    // MARK: load swiftData
    private func fetchTravelData() {
        dbManager = DBManager(modelContext: modelContext)
        
        if let firstTravel = dbManager?.fetchTravel() {
            travelItem = firstTravel[0]
        }
    }
}

#Preview {
    MainHeaderView()
}
