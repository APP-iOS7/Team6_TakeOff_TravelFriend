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
            dailyExpenses = expenses
        }
    }
    var body: some View {
        Chart {
            ForEach(dailyExpenses) { expense in
                BarMark(
                    x: .value("여행 일자", "\(expense.day)일차 경비"), // 어느 위치에 막대그래프를 쌓을 건가
                    y: .value("총 비용합", expense.price), // 값은 어떻게 매길 건가
                    width: .fixed(30)
                )
                .foregroundStyle(by: .value("Shape Color", expense.category)) // <- 색상 값
            }
        }
        .chartScrollableAxes(.horizontal) // enable scroll
        .frame(height: 300)
        .onAppear(perform: self.fetchDailyExpenses)
        
    }
}

//#Preview {
//    MainChartView(dailyExpenses: [
//        DailyExpense(day: 1, category: "Food", price: 12.5),
//        DailyExpense(day: 2, category: "Transport", price: 8.0),
//        DailyExpense(day: 3, category: "Entertainment", price: 15.0),
//        DailyExpense(day: 4, category: "Groceries", price: 30.0),
//        DailyExpense(day: 5, category: "Utilities", price: 50.0),
//        DailyExpense(day: 6, category: "Shopping", price: 25.0),
//        DailyExpense(day: 7, category: "Food", price: 18.0),
//        DailyExpense(day: 8, category: "Transport", price: 7.5),
//        DailyExpense(day: 9, category: "Healthcare", price: 40.0),
//        DailyExpense(day: 10, category: "Entertainment", price: 20.0)
//    ])
//}
