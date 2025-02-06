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
    
    var icon: String {
        switch self {
        case .ticket: return "🎟️"
        case .accommodation: return "🏨"
        case .shopping: return "🛍️"
        case .transportation: return "🚕"
        case .food: return "🍔"
        case .entertainment: return "🎬"
        case .souvenir: return "🎁"
        }
    }
    
    static func from(_ typeString: String) -> ExpenseCategoryType? {
        return ExpenseCategoryType.allCases.first { $0.rawValue == typeString }
    }
}

struct DailyExpenseListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var dbManager: DBManager?
    
    @State private var period: Int = 0
    
    @State private var showDailySpendingEditView: Bool = false
    @State private var isLoading: Bool = true // ✅ 로딩 상태 추가
    
    @State private var categoryAmount: [ExpenseCategoryType: String] = [:]
    @State private var isEditing: [ExpenseCategoryType: Bool] = [:] // 편집 여부 저장
    
    @State private var expenses: [DailyExpense] = []
    
    @State private var expandedDays: Set<Int> = [] // 펼쳐진 날짜 목록 (Set 사용)
    
    @State private var upsertList: [DailyExpense] = []
    
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
        Group {
            if isLoading {
                ProgressView("여행 정보를 불러오는 중...") // ✅ 로딩 화면
            } else {
                List {
                    // 일자별 총 지출 섹션
                    ForEach(1...period, id: \.self) { day in
                        Section {
                            Button(action: {
                                toggleSection(for: day)
                            }) {
                                HStack {
                                    Text("DAY \(day)")
                                        .fontWeight(.medium)
                                    Spacer()
                                    Text("\(groupedExpenses[day] ?? 0, specifier: "%.0f")원")
                                        .fontWeight(.bold)
                                }
                            }
                            .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일 제거
                            
                            // 🔽 Section이 펼쳐졌을 때 상세 내용 표시
                            if expandedDays.contains(day) {
                                let filteredList = expenses.filter { $0.day == day }
                                
                                VStack {
                                    ForEach(ExpenseCategoryType.allCases, id: \.self) { categoryType in
                                        let totalPrice = filteredList
                                            .filter { $0.category == categoryType.rawValue }
                                            .map { $0.price }
                                            .reduce(0, +) // 같은 카테고리의 가격을 합산
                                        
                                        HStack {
                                            Text((categoryType.icon) + " " + categoryType.rawValue)
                                                .font(.body)
                                                .foregroundColor(.primary)
                                                .frame(minWidth: 80, alignment: .leading) // 최소 너비 설정
                                            
                                            Spacer()
                                            
                                            if isEditing[categoryType] == true {
                                                // ✅ TextField 모드
                                                TextField("0원", text: Binding(
                                                    get: { categoryAmount[categoryType] ?? "\(totalPrice)" },
                                                    set: { newValue in categoryAmount[categoryType] = newValue }
                                                ))
                                                .keyboardType(.numberPad) // 숫자 키보드 사용
                                                .multilineTextAlignment(.trailing) // 오른쪽 정렬
                                                .font(.system(size: 14))
                                                .fontWeight(.bold)
                                                .frame(minWidth: 60, alignment: .trailing)
                                                .onSubmit {
                                                    isEditing[categoryType] = false // ✅ 입력 완료 후 Text로 변경
                                                }
                                                .onAppear {
                                                    categoryAmount[categoryType] = "" // ✅ TextField가 나타날 때 기존 값 설정
                                                }
                                            } else {
                                                Text("\(totalPrice, specifier: "%.0f")원")
                                                    .font(.system(size: 14))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(totalPrice > 0 ? .primary : .secondary) // 금액이 없으면 흐리게 처리
                                                    .onTapGesture {
                                                        isEditing[categoryType] = true // ✅ 클릭하면 TextField로 변경
                                                    }
                                            }
                                            
                                        }
                                        .padding(.vertical, 5) // 위아래 여백 추가
                                        
                                        Divider() // 구분선 추가
                                    }
                                    Button(action: {
                                        upsertList = categoryAmount.compactMap { category, priceString in
                                            guard let price = Double(priceString) else { return nil } // 숫자로 변환 실패 시 제외
                                            return DailyExpense(day: day, category: category.rawValue, price: price)
                                        }
                                        
                                        // 업데이트와 생성
                                        upsertDailyExpense(upsertList)
                                    }) {
                                        Text("수정하기")
                                            .fontWeight(.bold)
                                            .tint(.primaryBlue)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    
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
            }
        }
        .sheet(isPresented: $showDailySpendingEditView) {
            // EditDailySpendingView()
        }
        .onAppear {
            dbManager = DBManager(modelContext: modelContext)
            
            fetchTravelData()
            
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
    
    private func fetchTravelData() {
        dbManager = DBManager(modelContext: modelContext)
        
        if let firstTravel = dbManager?.fetchTravel().first {
            period = firstTravel.period
            isLoading = false
        }
    }
    
    private func upsertDailyExpense(_ expenses: [DailyExpense]) {
        for expense in expenses {
            dbManager?.upsertDailyExpense(expense)
        }
        
        // 화면 갱신
        getAllExpenses()
        
        // 수정된 값들 초기화
        isEditing = [:]
        categoryAmount = [:]
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
