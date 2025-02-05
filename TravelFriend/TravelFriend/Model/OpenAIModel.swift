//
//  OpenAIModel.swift
//  TravelFriend
//
//  Created by 이재용 on 2/5/25.
//

import Foundation

// MARK: - OpenAI API 모델 정의
struct OpenAIRequest: Codable {
    let model: String
    let messages: [Message]

    struct Message: Codable {
        let role: String
        let content: String
    }
}


struct OpenAIResponse: Codable {
    let choices: [Choice]
    
    struct Choice: Codable {
        let message: Message
        
        struct Message: Codable {
            let content: String
        }
    }
}

struct OpenAIErrorResponse: Codable {
    let error: OpenAIError
    
    struct OpenAIError: Codable {
        let message: String
    }
}
