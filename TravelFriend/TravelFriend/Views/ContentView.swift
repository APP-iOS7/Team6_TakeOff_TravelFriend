//
//  ContentView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var dbManager: DBManager?
    @State private var selectedTab: Int = 0
    
    @State private var shouldRefresh = false
    
    @State private var navigateToExchange: Bool = false     // 환율화면 네비게이션 상태 관리
    @State private var navigateToAddTravel: Bool = false    // 여행추가 네비게이션 상태 관리
    @State private var navigateToExpenseList: Bool = false  // 지출조회화면 네비게이션 상태 관리
    
    @State private var showSplashView = true
    
    @State private var travelItem: Travel?

    var body: some View {
        if showSplashView {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeOut(duration: 1.0)) {  // fade out 애니메이션
                            showSplashView = false
                        }
                    }
                }
                .transition(.opacity)  // transition 효과 추가
        } else {
            NavigationStack {
                TabView(selection: $selectedTab) {
                    
                    
                    // travelItem의 유무 [메인화면 <-> empty화면]
                    (travelItem != nil ? AnyView(MainView(shouldRefreshMain: $shouldRefresh)) : AnyView(EmptyMainView(navigateToAddTravel: $navigateToAddTravel)))
                        .tabItem {
                            Image(systemName: "house")
                            Text("홈")
                        }
                        .tag(0)
                    
                    (travelItem != nil ? AnyView(ChatBotView(country: travelItem?.location ?? "")) : AnyView(EmptyMainView(navigateToAddTravel: $navigateToAddTravel)))
                        .tabItem {
                            Image(systemName: "bubble.circle")
                            Text("챗봇")
                        }
                        .tag(1)
                    
                }
                .onChange(of: shouldRefresh) { _ in
                    print("shouldRefresh")
                    fetchTravelData()
                }
                .onAppear {
                    fetchTravelData()
                    let gyroManager = GyroManager.shared
                    gyroManager.setLocationText(travelItem?.location ?? "")
                }
                .toolbar {
                    // 툴바 좌측 환율 화면 이동 버튼
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { navigateToExchange = true }) {
                            Image(systemName: "wonsign.arrow.trianglehead.counterclockwise.rotate.90")
                        }
                        .tint(.primaryBlue)
                    }
                    // 툴바 우측 여행등록 화면 이동 버튼 (등록시에는 invisible)
                    if travelItem == nil {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { navigateToAddTravel = true }) {
                                Image(systemName: "plus")
                            }
                            .tint(.primaryBlue)
                        }
                    } else {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { navigateToExpenseList = true }) {
                                Image(systemName: "list.triangle")
                            }
                            .tint(.primaryBlue)
                        }
                    }
                }
                .navigationDestination(isPresented: $navigateToExchange) {
                    ExchangeView(location: travelItem?.location ?? "") // ExchangeView로 이동
                }
                .navigationDestination(isPresented: $navigateToAddTravel) {
                    AddTravelView() // ExchangeView로 이동
                }
                .navigationDestination(isPresented: $navigateToExpenseList) {
                    DailyExpenseListView() // DailyExpenseListView로 이동
                }
                
            }
        }
    }
    // MARK: load swiftData
    private func fetchTravelData() {
        dbManager = DBManager(modelContext: modelContext)
        
        if let firstTravel = dbManager?.fetchTravel().first {
            travelItem = firstTravel
        } else {
            travelItem = nil
        }
    }
}

struct SplashView: View {
    @State private var imageOffset: CGFloat = -UIScreen.main.bounds.width  // 화면 왼쪽 밖에서 시작
    @State private var opacity: Double = 1.0  // opacity 상태 추가
    
    var body: some View {
        ZStack {
            Image("LaunchScreenImage")
                .resizable()
                .scaledToFit()
                // .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // 화면 크기에 맞춤
                .clipped()
                .ignoresSafeArea()
                .opacity(opacity)
                
        }
    }
}


struct EmptyMainView: View {
    @Binding var navigateToAddTravel: Bool  // 🔹 바인딩 추가
    
    var body: some View {
        VStack(spacing: 16) {
            Text("🚀")
                .font(.system(size: 50)) // 큰 아이콘
            
            Text("아직 여행이 없어요!")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("여행을 추가하고 계획을 세워보세요.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: {
                navigateToAddTravel = true
            }) {
                Text("여행 추가하기")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryBlue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6)) // 연한 배경색 적용
        .ignoresSafeArea()
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Travel.self, inMemory: true) // 미리보기용 ModelContainer 설정
}
