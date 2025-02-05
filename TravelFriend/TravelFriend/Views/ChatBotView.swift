//
//  ChatBotView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI

struct ChatBotView: View {
    let networkManager = NetWorkManager<OpenAIResponse>()
    var country: String
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
                    .focused($isTextFieldFocused)
                    .onSubmit { requestGPT() } // ✅ Enter(완료) 입력 시 실행
                    .onTapGesture {
                        isButtonShowing = true // ✅ TextField 터치 시 버튼 보이게 하기
                    }
                    .onChange(of: isTextFieldFocused) { oldValue, newValue in
                        if newValue {
                            isButtonShowing = true
                        }
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
                let response = try await requestGPT4(prompt: makePrompt())
                DispatchQueue.main.async {
                    self.answer = response
                }
            } catch {
                print("❌ OpenAI API 요청 오류: \(error.localizedDescription)")
            }
        }
    }
    func makePrompt()-> String {
        return """
        \(location)에서 사용하는 \(self.country)어 회화 표현을 알려줘. 첫 줄에는 한국어 의미, 둘째 줄에는 \(country)어 원어 표기, 셋째 줄에는 \(country)어의 한국어 발음 표시로 제시해주고 총 15개 이상 표현을 제시해줘 형식은 아래와 같아 ### ✅ **와인샵에서 사용하는 일본어 회화 표현 (한국어 - 일본어 - 발음)**
        
        1. **이 와인은 어떤 맛인가요?**
           - このワインはどんな味ですか？
           - **고노 와인 와 돈나 아지 데스카?**

        2. **이 와인의 품종은 무엇인가요?**
           - このワインの品種は何ですか？
           - **고노 와인 노 힌슈 와 난 데스카?**

        3. **가장 인기 있는 와인은 무엇인가요?**
           - 一番人気のワインは何ですか？
           - **이치방 닌키 노 와인 와 난 데스카?**

        4. **추천해 주실 와인이 있나요?**
           - おすすめのワインはありますか？
           - **오스스메 노 와인 와 아리마스카?**

        5. **이 와인은 드라이한가요, 스위트한가요?**
           - このワインは辛口ですか、甘口ですか？
           - **고노 와인 와 카라쿠치 데스카, 아마쿠치 데스카?**

        6. **이 와인은 몇 년산인가요?**
           - このワインは何年物ですか？
           - **고노 와인 와 난넨모노 데스카?**

        7. **이 와인의 도수는 몇 도인가요?**
           - このワインのアルコール度数は何度ですか？
           - **고노 와인 노 아루코루 도스 와 난도 데스카?**

        8. **화이트 와인과 레드 와인 중 어떤 걸 추천하시나요?**
           - 白ワインと赤ワイン、どちらがおすすめですか？
           - **시로 와인 토 아카 와인, 도치라 가 오스스메 데스카?**

        9. **와인과 어울리는 음식은 무엇인가요?**
           - このワインに合う料理は何ですか？
           - **고노 와인 니 아우 료리 와 난 데스카?**

        10. **이 와인은 어디에서 생산되었나요?**
           - このワインはどこで生産されましたか？
           - **고노 와인 와 도코 데 세이산 사레마시타카?**

        11. **와인을 시음해볼 수 있나요?**
           - 試飲できますか？
           - **시인 데키마스카?**

        12. **냉장 보관이 필요한가요?**
           - 冷蔵保存が必要ですか？
           - **레이조 호존 가 히츠요 데스카?**

        13. **이 와인을 선물용으로 포장해 주실 수 있나요?**
           - このワインをプレゼント用に包装してもらえますか？
           - **고노 와인 오 푸레젠토요 니 호소 시테 모라에마스카?**

        14. **지불은 현금만 가능한가요, 카드도 되나요?**
           - 支払いは現金のみですか？カードも使えますか？
           - **시하라이 와 겐킨 노미 데스카? 카도 모 츠카에마스카?**

        15. **이 와인 한 병 주세요.**
           - このワインを一本ください。
           - **고노 와인 오 잇뽄 쿠다사이.**

        이제 일본의 와인샵에서도 자연스럽게 소통할 수 있겠네요! 🍷🇯🇵 
"""
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
        model: "gpt-4o",
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
    ChatBotView(country: "일본")
}
