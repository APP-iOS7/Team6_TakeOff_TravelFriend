//
//  MainChartView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI

struct MainChartView: View {
    struct CategoryData {
        let name: String
        let value: CGFloat
        let color: Color
    }
    
    struct BarData {
        let totalValue: CGFloat
        let categories: [CategoryData]
    }
    
    let barData: [BarData] = [
        BarData(totalValue: 100, categories: [
            CategoryData(name: "식비", value: 40, color: .red),
            CategoryData(name: "교통", value: 30, color: .blue),
            CategoryData(name: "숙박", value: 30, color: .green)
        ]),
        BarData(totalValue: 150, categories: [
            CategoryData(name: "식비", value: 50, color: .red),
            CategoryData(name: "교통", value: 50, color: .blue),
            CategoryData(name: "숙박", value: 50, color: .green)
        ]),
        BarData(totalValue: 200, categories: [
            CategoryData(name: "식비", value: 80, color: .red),
            CategoryData(name: "교통", value: 60, color: .blue),
            CategoryData(name: "숙박", value: 60, color: .green)
        ])
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .bottom, spacing: 16) {
                Spacer()
                ForEach(barData.indices, id: \.self) { index in
                    let bar = barData[index]
                    
                    VStack {
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2)) // 막대 배경
                                .frame(width: 40, height: 200)
                            
                            VStack(spacing: 0) {
                                ForEach(bar.categories.indices, id: \.self) { catIndex in
                                    let category = bar.categories[catIndex]
                                    Rectangle()
                                        .fill(category.color)
                                        .frame(width: 40, height: (category.value / bar.totalValue) * 200) // 비율 계산
                                }
                            }
                        }
                        Text("\(Int(bar.totalValue))") // 총합 표시
                            .font(.caption)
                    }
                    .frame(width: 150)
                }
                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    MainChartView()
}
