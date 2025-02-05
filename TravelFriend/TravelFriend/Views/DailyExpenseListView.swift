//
//  DailyExpenseListView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/5/25.
//

import SwiftUI

enum ExpenseCategoryType: String, CaseIterable {
    case ticket = "입장료"
    case accommodation = "숙소비"
    case shopping = "쇼핑"
    case transportation = "교통비"
    case food = "식비"
    case entertainment = "문화/공연"
    case souvenir = "기념품"
    case etc = "기타"
    
    var icon: String {
        switch self {
        case .ticket: return "🎟️"
        case .accommodation: return "🏨"
        case .shopping: return "🛍️"
        case .transportation: return "🚕"
        case .food: return "🍔"
        case .entertainment: return "🎬"
        case .souvenir: return "🎁"
        case .etc: return ""
        }
    }
    
    // 한글 문자열을 이용해 Enum 값 찾기
    init?(rawValue: String) {
        switch rawValue {
        case "입장료":
            self = .ticket
        case "숙소비":
            self = .accommodation
        case "쇼핑":
            self = .shopping
        case "교통비":
            self = .transportation
        case "식비":
            self = .food
        case "문화/공연":
            self = .entertainment
        case "기념품":
            self = .souvenir
        default:
            self = .etc
        }
    }
}

struct DailyExpenseListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var dbManager: DBManager?
    
    @State private var expenses: [DailyExpense] = []
    
    @State private var expandedDays: Set<Int> = [] // 펼쳐진 날짜 목록 (Set 사용)
    
    // 일자별 총 지출 계산
    var groupedExpenses: [Int: Double] {
        expenses.reduce(into: [Int: Double]()) { result, expense in
            result[expense.day, default: 0] += expense.price
        }
    }
    var totalExpense: Double {
        expenses.reduce(0) { $0 + $1.price }
    }
    
    var body: some View {
        List {
            // 일자별 총 지출 섹션
            ForEach(groupedExpenses.keys.sorted(), id: \.self) { day in
                Section {
                    Button(action: {
                        toggleSection(for: day)
                    }) {
                        HStack {
                            Text("DAY \(day)")
                                .fontWeight(.regular)
                            Spacer()
                            Text("\(groupedExpenses[day] ?? 0, specifier: "%.0f")원")
                                .fontWeight(.bold)
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일 제거
                    
                    // 🔽 Section이 펼쳐졌을 때 상세 내용 표시
                    if expandedDays.contains(day) {
                        let filteredList = expenses.filter {$0.day == day}
                     
                        VStack {
                            ForEach(filteredList, id: \.id) { item in
                                HStack {
                                    Text(item.category) // 아이콘이 있다면 여기에 추가 가능
                                        .font(.body)
                                        .foregroundColor(.primary)
                                        .frame(minWidth: 80, alignment: .leading) // 최소 너비 설정
                                    
                                    Spacer()
                                    
                                    Text("\(item.price, specifier: "%.0f")원")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                }
                                .padding(.vertical, 5) // 위아래 여백 추가
                                
                                Divider() // 구분선 추가
                            }
                        }
                    }
                }
            }
            
            // 총 지출 섹션
            Section {
                HStack {
                    Text("총 지출")
                        .font(.headline)
                    Spacer()
                    Text("\(totalExpense, specifier: "%.0f")원")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryOrange)
                }
                .padding(.vertical, 5)
            }
        }
        .onAppear {
            dbManager = DBManager(modelContext: modelContext)
            
            getAllExpenses()
        }
        .listStyle(.insetGrouped)
        .navigationTitle("지출 내역")
    }
    
    // 지출 정보를 불러오는 함수
    private func getAllExpenses() {
        if let expenseList = dbManager?.fetchExpenses() {
            expenses = expenseList
        }
    }
    
    // ✅ Section 토글 함수
    private func toggleSection(for day: Int) {
        if expandedDays.contains(day) {
            expandedDays.remove(day) // 닫기
        } else {
            expandedDays.insert(day) // 열기
        }
    }
}

#Preview {
    DailyExpenseListView()
}
