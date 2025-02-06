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
    
    @State private var showingAlert = false // 알럿 표시 여부를 제어하는 상태 변수
    
    @Binding var shouldRefresh: Bool  // 추가
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("✈️ 여행 정보")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    showingAlert = true
                    print("버튼 클릭")
                }) {
                    Text("🗑️")
                }.frame(alignment: .trailing) // 버튼을 우측 정렬
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("📍 여행지")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(travelItem?.location ?? "미정")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("💰 총 예산")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(travelItem?.budget.commaSeparatedString ?? "0") 원")
                        .foregroundColor(.blue)
                        .bold()
                }
                
                HStack {
                    Text("🗓 여행 기간")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(travelItem?.period ?? 1)일")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color.white) // 카드 스타일
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2) // 그림자
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.primarySkyblue.opacity(0.3)) // 연한 배경색
        .cornerRadius(12)
        .onAppear {
            fetchTravelData()
        }
        .alert("삭제 확인", isPresented: $showingAlert) {
            Button("취소", role: .cancel) { }
            Button("삭제", role: .destructive) {
                // 여기에 삭제 로직 추가
                deleteTravel()
                deleteAllExpenses()
            }
        } message: {
            Text("정말 삭제하시겠습니까?")
        }
    }
    // MARK: load swiftData
    private func fetchTravelData() {
        dbManager = DBManager(modelContext: modelContext)
        
        if let firstTravel = dbManager?.fetchTravel().first {
            travelItem = firstTravel
        }
    }
    
    private func deleteTravel() {
        if let travelItem = travelItem {
            dbManager?.deleteItem(travelItem)
            print("삭제")
        }
        shouldRefresh.toggle()
    }
    
    private func deleteAllExpenses() {
        dbManager?.deleteAllExpenses()
    }
}

#Preview {
    MainHeaderView(shouldRefresh: .constant(false))
}
