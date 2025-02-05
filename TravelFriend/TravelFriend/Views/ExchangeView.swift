//
//  ExchangeView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI
import CoreMotion
//import Foundation

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
    @State private var index: Int = 0 // 카운트 체크용 삭제할 것
    @State private var inputMoney: Double = 1
    @State private var inputMoneyString: String = ""
    @State private var exchangeMoney: Double? = nil
    @State private var isEditing = false // 수정 상태 체크
    
    private let motionManager = CMMotionManager()
    
    let currencyValue = ["🇨🇳 CNY", "🇪🇺 EUR", "🇯🇵 JPY", "🇰🇷 KRW", "🇺🇸 USD"] //중국, 유로, 일본, 대한민국, 미국
    let currencyText = ["CNY", "EUR", "JPY", "KRW", "USD"] //중국, 유로, 일본, 대한민국, 미국
    
    @State private var currencyString: String = "KRW"
    var location: String // 여행지
    
    @State private var showRepeatSheet = false // 팝업 표시 여부
    @State private var selectedRepeat = "USD" // 선택된 currencyValue 저장
    
    var body: some View
    {
        VStack
        {
            VStack
            {
                Text("테스트용 텍스트")
                Text(location)
                Spacer()
                
                Button
                {
                    showRepeatSheet = true // 팝업 열기
                }
                label: {
                    HStack {
                        Spacer()
                        Text("테스트용 버튼")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                }
                .padding()
                .frame(maxWidth: 180)
            }
            .sheet(isPresented: $showRepeatSheet) {
                VStack(alignment: .leading,
                       spacing: 12)
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
                            Text(selectedRepeat == "" ? "🏳️ 국가 선택" : "USD")
                                .fontWeight(.semibold)
                            Spacer()
                            
                            if (isEditing)
                            {
                                TextField("\(inputMoney, specifier: "%.2f")", text: $inputMoneyString)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.decimalPad) // 숫자 키패드 표시
                                    .onChange(of: inputMoneyString)
                                { newValue in
                                    inputMoney = Double(newValue) ?? 0.0
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
                    .background(Color.white) // 카드 스타일
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2) // 그림자
                    
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
                    fetchExchangeRate()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.primarySkyblue.opacity(0.3)) // 연한 배경색
                .cornerRadius(12)
                .presentationDetents([.fraction(0.4)]) // 하단 팝업 크기 지정
            }
        }
    }
    
    // 모션 값 확인
    func startMonitoringMotion()
    {
        if (motionManager.isAccelerometerAvailable)
        {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main)
            { data, error in
                if let data = data
                {
                    let zAcceleration = data.acceleration.z
                    
                    // 폰 터치 시 Z축 가속도 변화 감지
#if DEBUG
                    index = index + 1
                    print("[D]zAcceleration = \(zAcceleration) / cnt \(index)")
#endif
                    if (zAcceleration > 1.0) // 값 조절 하면서 테스트 중
                    {
                        backTapDetected = true
                        
                        // 잦은 감지 방지 1초 후 다시 감지
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                        {
                            backTapDetected = false
                        }
                    }
                }
            }
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

#Preview {
    ExchangeView(location: "한국")
}
