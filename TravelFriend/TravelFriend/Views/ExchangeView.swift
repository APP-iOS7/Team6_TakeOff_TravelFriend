//
//  ExchangeView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI
import CoreMotion

// JSON 데이터 모델
struct ExchangeRateResponse: Codable
{
    let conversion_rates: [String: Double]
}

// ExchangeView
struct ExchangeView: View
{
    @State private var backTapDetected = false // 백텝 체크
    @State private var exchangeRate: Double? = nil // 환율 데이터를 저장 할 변수
    @State private var isLoading = false // 로딩 상태 체크
    @State private var inputMoney: Double = 1
    @State private var inputMoneyString: String = ""
    @State private var exchangeMoney: Double? = nil
    @State private var isEditing = false // 수정 상태 체크
    @State private var showRepeatSheet = false // 팝업 상태 체크
    @State private var currencyString: String = ""
    var location: String // 받은 여행지
    private let motionManager = CMMotionManager()
//    let currencyValue = ["🇨🇳 CNY", "🇪🇺 EUR", "🇯🇵 JPY", "🇰🇷 KRW", "🇺🇸 USD"] //중국, 유로, 일본, 대한민국, 미국
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 12)
        {
            Text("🏦 환율 정보")
                .font(.title2)
                .fontWeight(.bold)
            VStack(alignment: .leading, spacing: 8)
            {
                HStack
                {
                    Spacer()
                    Text("🇰🇷 KRW")
                        .fontWeight(.semibold)
                    Spacer()
                    if let rate = exchangeMoney
                    {
                        Text("\(rate, specifier: "%.2f")₩")
                    }
                    else
                    {
                        Text("환율 확인 실패.")
                            .foregroundStyle(.red)
                    }
                    Spacer()
                }
                
                HStack
                {
                    Spacer()
                    Image(systemName: "arrow.trianglehead.2.clockwise")
                    Spacer()
                }
                
                HStack
                {
                    Spacer()
                    Text(currencyString == "" ? "🏳️ 국가 선택" : currencyString)
                        .fontWeight(.semibold)
                    Spacer()
                    
                    if (isEditing)
                    {
                        TextField("\(inputMoney, specifier: "%.2f")", text: $inputMoneyString)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad) // 숫자 키패드 표시
                            .onChange(of: inputMoneyString, initial: true)
                            { _, newValue in
                                inputMoney = Double(newValue) ?? 1.0
                            }
                    }
                    else
                    {
                        Text("\(inputMoney, specifier: "%.2f")")
                            .onTapGesture
                        {
                            isEditing = true
                        }
                    }
                    Spacer()
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
            
            HStack
            {
                Spacer()
                Button
                {
                    exchangeMoney = (exchangeRate ?? 0) * inputMoney
                    isEditing = false
                }
                label:
                {
                    Text("계산하기")
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
        }
        .onAppear
        {
            currencyStringCheck()
            fetchExchangeRate()
        }
        .onChange(of: backTapDetected, initial: true)
        { _, newValue in
            if newValue {
                showRepeatSheet = true
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.primarySkyblue.opacity(0.3)) // 연한 배경색
        .cornerRadius(12)
        .presentationDetents([.fraction(0.4)]) // 하단 팝업 크기 지정
        
        
    }
    
    
    // 여행지 값 확인
    func currencyStringCheck()
    {
        switch (location)
        {
            //중국, 유로, 일본, 대한민국, 미국
            //["🇨🇳 CNY", "🇪🇺 EUR", "🇯🇵 JPY", "🇰🇷 KRW", "🇺🇸 USD"]
            case "중국":
                print("[D]CNY Check")
                currencyString = "CNY"
                
            case "유럽":
                print("[D]EUR Check")
                currencyString = "EUR"
                
            case "일본":
                print("[D]JPY Check")
                currencyString = "JPY"
                
            case "대한민국":
                print("[D]KRW Check")
                currencyString = "KRW"
                
            case "미국":
                print("[D]USD Check")
                currencyString = "USD"
                
            default:
                print("[E]currencyStringCheck ERROR")
        }
    }
    
    // API 호출
    func fetchExchangeRate()
    {
        let apiKey = "4b597ef50394df1e48da30c6"
        let urlString = "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(currencyString)"
        
        guard let url = URL(string: urlString)
        else
        {
            return
        }
        
        isLoading = true  // 로딩 시작
        
        URLSession.shared.dataTask(with: url)
        { data, response, error in
            isLoading = false  // 로딩 종료
            
            guard let data = data, error == nil
            else
            {
                print("데이터 가져오기 실패: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do
            {
                let result = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                DispatchQueue.main.async
                {
                    self.exchangeRate = result.conversion_rates["KRW"] //여행지 환율
                    self.exchangeMoney = self.exchangeRate
                }
            }
            catch
            {
                print("[E]JSONDecoder : \(error.localizedDescription)")
            }
        }
        .resume()
    }
}

//#Preview {
//    ExchangeView(location: "한국")
//}
