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
    
    /// 데이터 추가
    func addItem(_ item: Travel) {
        modelContext.insert(item)
        saveContext()
    }
    
    /// 데이터 삭제
    func deleteItem(_ item: Travel) {
        modelContext.delete(item)
        saveContext()
    }
    
    /// 모든 데이터 가져오기
    func fetchTravel() -> [Travel] {
        let descriptor = FetchDescriptor<Travel>()
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
