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
    
    /// 특정 조건으로 데이터 가져오기
    /*
    func fetchTravels(withName name: String) -> [Travel] {
        let descriptor = FetchDescriptor<Item>(predicate: #Predicate { $0. == name })
        return (try? modelContext.fetch(descriptor)) ?? []
    }
     */
    

    /// 데이터 저장
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}
