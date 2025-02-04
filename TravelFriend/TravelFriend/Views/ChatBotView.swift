//
//  ChatBotView.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//

import SwiftUI

struct ChatBotView: View {
    @State var question: String = ""
    
    // TODO: 
    
    

    
    var body: some View {
        VStack {
            //TODO: Gpt 결과 받아와서 표출
            
            
            Spacer()
            
            // 버튼 선택하면 사라져야함
            LocationSugestionView(location: $question)
            
            TextField("어떤 장소에 있나요?", text: $question)
                .padding()
                .background(.primaryBlue)
                //.clipShape(.rect(cornerRadius: 5))
            
            
        }
        .background(.primarySkyblue)
    }
}

struct LocationSugestionView : View {
    
    @Binding var location: String
    
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
                    LocationButton(location: $location, buttonTitle: location)
                }
            }
        }
    }
    
}

struct LocationButton: View {
    @Binding var location: String
    let buttonTitle: String
    
    
    var body: some View {
        Button {
            location = buttonTitle
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
//#Preview {
//    ChatBotView()
//}
