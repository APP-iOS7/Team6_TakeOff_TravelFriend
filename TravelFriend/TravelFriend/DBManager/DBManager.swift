//
//  DBManager.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//
import Foundation
import SwiftData

@Observable
class DBManager {
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// 데이터 추카
    func addItem(_ item: Any) {
        
        if let item = item as? Travel {
            modelContext.insert(item)
        }
        
        if let spendItem = item as? DailyExpense {
            modelContext.insert(spendItem)
        }
        
        saveContext()
    }
    
    /// 데이터 삭제
    func deleteItem(_ item: Any) {
        if let item = item as? Travel {
            modelContext.delete(item)
        }
        
        if let spendItem = item as? DailyExpense {
            modelContext.delete(spendItem)
        }
        
        saveContext()
    }
    
    func deleteAllExpenses() {
        // DailyExpense 데이터 모두 삭제
        let expenseFetchDescriptor = FetchDescriptor<DailyExpense>()
        if let expenses = try? modelContext.fetch(expenseFetchDescriptor) {
            expenses.forEach { expense in
                modelContext.delete(expense)
            }
        }
        saveContext()
    }
    
    /// 여행 데이터 가져오기
    func fetchTravel() -> [Travel] {
        let descriptor = FetchDescriptor<Travel>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    /// 지출 데이터 가져오기
    func fetchExpenses() -> [DailyExpense] {
        let descriptor = FetchDescriptor<DailyExpense>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    /// 일별로 지출 데이터 가져오기
    func fetchDailyExpenses(withday day: Int) -> [DailyExpense] {
        let descriptor = FetchDescriptor<DailyExpense>(predicate: #Predicate { $0.day == day })
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    /// 데이터 추가 또는 업데이트 (Upsert)
    func upsertDailyExpense(_ expense: DailyExpense) {
        // 같은 day의 데이터를 가져옴
        let expenses = fetchDailyExpenses(withday: expense.day)
        
        // 같은 category가 있는지 확인
        if let existingExpenseIndex = expenses.firstIndex(where: { $0.category == expense.category }) {
            // 기존 데이터가 있으면 price만 업데이트
            expenses[existingExpenseIndex].price = expense.price
        } else {
            // 기존 데이터가 없으면 새로 추가
            modelContext.insert(expense)
        }
        
        saveContext()
    }
    

    /// 데이터 저장
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}
