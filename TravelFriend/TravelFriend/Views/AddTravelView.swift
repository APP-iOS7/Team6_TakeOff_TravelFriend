//
//  AddTravelView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/5/25.
//

import SwiftUI

struct AddTravelView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var dbManager: DBManager?
    
    @State private var location: String = ""
    @State private var travelDays: Int = 1
    @State private var budget: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("여행 정보")) {
                HStack {
                    Text("📍 여행지")
                    Spacer()
                    TextField("여행지를 입력하세요", text: $location)
                        .multilineTextAlignment(.trailing) // 오른쪽 정렬
                }
            }
            
            Section(header: Text("여행 일정")) {
                Picker("🗓 여행 일수", selection: $travelDays) {
                    ForEach(1...30, id: \.self) { day in // FIXME: 일수는 다시 정해서 넣어두기
                        Text("\(day)일")
                    }
                }
                .pickerStyle(MenuPickerStyle()) // 드롭다운 스타일 적용
            }
            
            Section(header: Text("여행 예산")) {
                HStack {
                    Text("💰 예산")
                    Spacer()
                    TextField("예산 입력", text: $budget)
                        .keyboardType(.decimalPad) // 숫자 키보드 적용
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        .onAppear {
            self.dbManager = DBManager(modelContext: modelContext)
        }
        .navigationTitle("여행 경비 설정")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // 정보 저장
                    saveTravel()
                    dismiss()
                }) {
                    Text("저장")
                }
            }
        }
    }
    
    private func saveTravel() {
        guard !location.isEmpty else {
            return
        }
        
        let travel = Travel()
        travel.location = location
        travel.budget = Double(budget) ?? 0
        travel.period = travelDays
        
        dbManager?.addItem(travel)
    }
}

#Preview {
    AddTravelView()
}
