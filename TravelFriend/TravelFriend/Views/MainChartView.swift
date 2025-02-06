//
//  MainChartView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI
import Charts


struct MainChartView: View {
    @Environment(\.modelContext) private var modelContext
    @State var dailyExpenses: [DailyExpense]
    @State private var dbManager: DBManager?
    
    private func fetchDailyExpenses() {
        dbManager = DBManager(modelContext: modelContext)
        
        if let expenses = dbManager?.fetchExpenses() {
            dailyExpenses = expenses.sorted(by: { one, two in
                one.day < two.day
            })
        }
    }
    
    var body: some View {
        
        if dailyExpenses.isEmpty {
            MainChartEmptyView()
                .onAppear(perform: {
                self.fetchDailyExpenses()
                print(dailyExpenses)
            })
        } else {
            Chart {
                ForEach(dailyExpenses) { expense in
                    BarMark(
                        x: .value("여행 일자", "\(expense.day)일차 경비"), // 문자열 유지
                        y: .value("총 비용합", expense.price),
                        width: .fixed(30) // 막대 너비 고정
                    )
                    .foregroundStyle(by: .value("Shape Color", expense.category))
                }
            }
            .chartXVisibleDomain(length: 5)
            .chartScrollableAxes(.horizontal)
            .frame(height: 300)
            .onAppear(perform: {
                self.fetchDailyExpenses()
                print(dailyExpenses)
            })
        }
    }
}
extension MainChartView {
    func getCntOfDays() -> Int {
        return Set(dailyExpenses.map { $0.day }).count
    }
}

struct MainChartEmptyView: View {
    var body: some View {
        VStack {
            Image(systemName: "chart.bar.xaxis.ascending")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
            Text("차트를 표시하기 위해\n지출 내역을 입력해 주세요")
                .padding()
                .multilineTextAlignment(.center)
        }
        
            .frame(maxWidth: .infinity, maxHeight: 300)
    }
}

#Preview {
    MainChartView(dailyExpenses: [])
}
