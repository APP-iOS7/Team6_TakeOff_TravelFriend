//
//  ChatBotView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI

struct ChatBotView: View {
    let networkManager = NetWorkManager<OpenAIResponse>()
    let country: String = "일본"
    @State var location: String = ""
    @State var isAnswerIsGenerating: Bool = false // 응답 생성 중인지
    @State var isButtonShowing: Bool = true
    @State var answer: String = ""
    @FocusState private var isTextFieldFocused: Bool  // ✅ 포커스 상태 추가
    
    
    // TODO:
    var body: some View {
        ZStack{
            VStack {
                //TODO: Gpt 결과 받아와서 표출
                if answer != "" {
                    ScrollView {
                        Text(answer)
                    }
                    .padding()
                    .background(.primarySkyblue)
                    
                }
                
                
                Spacer()
                
                // 버튼 선택하면 사라져야함
                if isButtonShowing {
                    LocationSugestionView(location: $location, isButtonShowing: $isButtonShowing, requestGPT: requestGPT)
                }
                
                
                
                
                TextField("어떤 장소에 있나요?", text: $location)
                    .padding()
                    .background(.primaryBlue)
                //.clipShape(.rect(cornerRadius: 5))
                    .onSubmit { requestGPT() } // ✅ Enter(완료) 입력 시 실행
                    .onTapGesture {
                        isButtonShowing = true // ✅ TextField 터치 시 버튼 보이게 하기
                    }
            }
            .background(.primarySkyblue)
            
            //
            if isAnswerIsGenerating {
                Spacer()
                Text("응답을 생성 중...🚀")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
        }
        
        
    }
}
extension ChatBotView {
    func requestGPT() {
        Task {
            self.answer = ""
            isAnswerIsGenerating = true
            
            defer {
                DispatchQueue.main.async {
                    self.isAnswerIsGenerating = false
                }
            }
            do {
                let response = try await requestGPT4(prompt: "\(location)에서 사용하는 \(self.country)어 회화 표현을 알려줘. 첫 줄에는 한국어 의미, 둘째 줄에는 \(country)어 표기, 셋째 줄에는 \(country)어의 한국어 발음 표기로 제시해주고 총 15개 이상 표현을 제시해줘")
                DispatchQueue.main.async {
                    self.answer = response
                }
            } catch {
                print("❌ OpenAI API 요청 오류: \(error.localizedDescription)")
            }
        }
    }
}

struct LocationSugestionView : View {
    
    @Binding var location: String
    @Binding var isButtonShowing: Bool
    var requestGPT: () -> Void // ✅ 함수 전달
    
    var columns: [GridItem] = [GridItem(.adaptive(minimum: 100))]
    var locationList: [String] = [
        "식당", "카페", "술집", "랜드마크", "박물관",
        "유적지", "쇼핑몰", "시장", "기차역", "버스정류장",
        "공항", "호텔", "극장", "티켓판매소", "병원"
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(self.locationList, id: \.self) { location in
                    LocationButton(location: $location, isButtonShowing: $isButtonShowing, requestGPT: requestGPT, buttonTitle: location)
                }
            }
        }
    }
    
}

struct LocationButton: View {
    @Binding var location: String
    @Binding var isButtonShowing: Bool
    
    var requestGPT: () -> Void // ✅ 함수 전달
    let buttonTitle: String
    var body: some View {
        Button {
            location = buttonTitle
            isButtonShowing = false
            requestGPT() // ✅ 버튼 클릭 시 requestGPT() 실행
            
        } label: {
            Text(buttonTitle)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(.primaryOrange)
                .foregroundColor(.white)
                .clipShape(.rect(cornerRadius: 5))
        }
        
    }
}

fileprivate func requestGPT4(prompt: String) async throws -> String {
    let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
    let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    
    let requestBody = OpenAIRequest(
        model: "gpt-4o-mini",
        messages: [
            OpenAIRequest.Message(role: "system", content: "You are a helpful assistant."),
            OpenAIRequest.Message(role: "user", content: prompt)
        ]
    )
    
    request.httpBody = try JSONEncoder().encode(requestBody)
    
    printRequest(request)
    
    let (data, _) = try await URLSession.shared.data(for: request)
    
    // ✅ JSON 응답을 사람이 읽을 수 있도록 출력
    //    if let jsonString = String(data: data, encoding: .utf8) {
    //        print("🔹 OpenAI 응답 JSON:\n\(jsonString)")
    //    }
    
    // ✅ 먼저 오류 응답인지 확인
    if let errorResponse = try? JSONDecoder().decode(OpenAIErrorResponse.self, from: data) {
        throw NSError(domain: "OpenAI API 오류", code: 1, userInfo: [NSLocalizedDescriptionKey: errorResponse.error.message])
    }
    
    // ✅ 정상적인 OpenAI 응답 처리
    let response = try JSONDecoder().decode(OpenAIResponse.self, from: data)
    return response.choices.first?.message.content ?? "No response"
}
#Preview {
    ChatBotView()
}
