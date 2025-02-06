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
                    x: .value("여행 일자", "\(expense.day)일차 경비"), // 문자열 유지
                    y: .value("총 비용합", expense.price),
                    width: .fixed(30) // 막대 너비 고정
                )
                .foregroundStyle(by: .value("Shape Color", expense.category))
            }
        }
        .chartXVisibleDomain(length: 1)
        .chartScrollableAxes(getCntOfDays() >= 10 ? .horizontal : [])
        .frame(height: 300)
        .onAppear(perform: self.fetchDailyExpenses)
        
    }
}
extension MainChartView {
    func getCntOfDays() -> Int {
            return Set(dailyExpenses.map { $0.day }).count
        }
}

#Preview {
    MainChartView(dailyExpenses: [
        DailyExpense(day: 1, category: "Food", price: 12.5),
        DailyExpense(day: 1, category: "Transport", price: 8.0),
        DailyExpense(day: 1, category: "Entertainment", price: 15.0),
        DailyExpense(day: 2, category: "Groceries", price: 30.0),
        DailyExpense(day: 2, category: "Utilities", price: 50.0),
        DailyExpense(day: 3, category: "Shopping", price: 25.0),
        DailyExpense(day: 4, category: "Food", price: 18.0),
        DailyExpense(day: 3, category: "Transport", price: 7.5),
        DailyExpense(day: 3, category: "Healthcare", price: 40.0),
        DailyExpense(day: 4, category: "Entertainment", price: 20.0)
//        DailyExpense(day: 5, category: "Food", price: 12.5),
//        DailyExpense(day: 6, category: "Transport", price: 8.0),
//        DailyExpense(day: 7, category: "Entertainment", price: 15.0),
//        DailyExpense(day: 8, category: "Groceries", price: 30.0),
//        DailyExpense(day: 9, category: "Utilities", price: 50.0),
//        DailyExpense(day: 10, category: "Shopping", price: 25.0),
//        DailyExpense(day: 11, category: "Food", price: 18.0),
//        DailyExpense(day: 12, category: "Transport", price: 7.5),
//        DailyExpense(day: 13, category: "Healthcare", price: 40.0),
//        DailyExpense(day: 14, category: "Entertainment", price: 20.0),
//        DailyExpense(day: 15, category: "Healthcare", price: 40.0),
//        DailyExpense(day: 16, category: "Entertainment", price: 20.0),
//        DailyExpense(day: 17, category: "Food", price: 12.5),
//        DailyExpense(day: 18, category: "Transport", price: 8.0),
//        DailyExpense(day: 19, category: "Entertainment", price: 15.0),
//        DailyExpense(day: 20, category: "Groceries", price: 30.0),
//        DailyExpense(day: 21, category: "Utilities", price: 50.0),
//        DailyExpense(day: 23, category: "Shopping", price: 25.0),
//        DailyExpense(day: 22, category: "Food", price: 18.0),
//        DailyExpense(day: 23, category: "Transport", price: 7.5),
//        DailyExpense(day: 13, category: "Healthcare", price: 40.0),
//        DailyExpense(day: 14, category: "Entertainment", price: 20.0)
    ])
}
