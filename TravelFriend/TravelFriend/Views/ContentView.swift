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

    var body: some View {
        NavigationStack {
            TabView {
                MainView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("홈")
                    }
                
                ChatBotView()
                    .tabItem {
                        Image(systemName: "bubble.circle")
                        Text("챗봇")
                    }
                
                ExchangeView()
                    .tabItem {
                        Image(systemName: "checklist")
                        Text("체크리스트")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // TODO: 환율 화면 진입
                        print("환율 화면 진입")
                    }) {
                        Image(systemName: "wonsign.arrow.trianglehead.counterclockwise.rotate.90")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Travel.self, inMemory: true) // 미리보기용 ModelContainer 설정
}
