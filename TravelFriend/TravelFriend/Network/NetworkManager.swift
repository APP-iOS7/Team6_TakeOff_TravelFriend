//
//  NetworkManager.swift
//  TravelFriend
//
//  Created by 박세라 on 2/4/25.
//


import Foundation

// MARK: - NetworkManager (Generic)
class NetWorkManager<Model: Decodable> {
    
    /// HTTP 요청을 수행하는 메서드 (GET, POST, PUT, DELETE 모두 지원)
    private func requestHttp(
        model: Model.Type,
        urlString: String,
        method: String,  // HTTP 메서드 (GET, POST, PUT, DELETE)
        headers: [(headerValue: String, headerField: String?)] = [], // HTTP 헤더
        body: Data? = nil  // POST/PUT 요청 시 body 추가
    ) async throws -> Model {
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method  // ✅ HTTP 메서드 설정
        
        // ✅ 헤더 추가
        for header in headers {
            if let field = header.headerField {
                request.addValue(header.headerValue, forHTTPHeaderField: field)
            }
        }
        
        // ✅ POST/PUT 요청 시 body 설정
        if let body = body, method == "POST" || method == "PUT" {
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") // JSON 요청 기본 추가
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(Model.self, from: data)
    }
}

// MARK: - NetWorkManager 확장 (기본 HTTP 메서드 지원)
extension NetWorkManager {
    
    // ✅ GET 요청 (Fetch)
    func fetch(url: String, headers: [(String, String?)] = []) async throws -> Model {
        return try await requestHttp(model: Model.self, urlString: url, method: "GET", headers: headers)
    }
    
    // ✅ DELETE 요청
    func delete(url: String, headers: [(String, String?)] = []) async throws -> Model {
        return try await requestHttp(model: Model.self, urlString: url, method: "DELETE", headers: headers)
    }
    
    // ✅ POST 요청 (Body 포함)
    func post(url: String, body: Data, headers: [(String, String?)] = []) async throws -> Model {
        return try await requestHttp(model: Model.self, urlString: url, method: "POST", headers: headers, body: body)
    }
    
    // ✅ PUT 요청 (Body 포함)
    func put(url: String, body: Data, headers: [(String, String?)] = []) async throws -> Model {
        return try await requestHttp(model: Model.self, urlString: url, method: "PUT", headers: headers, body: body)
    }
}

// MARK: - OpenAI API 요청 확장
extension NetWorkManager where Model == OpenAIResponse {
    
    /// OpenAI API 요청을 수행하는 메서드
    func requestGPT4(prompt: String) async throws -> String {
        let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
        let url = "https://api.openai.com/v1/chat/completions"

        let requestBody = OpenAIRequest(
            model: "gpt-4o",
            messages: [
                ["role": "system", "content": "You are a helpful assistant."],
                ["role": "user", "content": prompt]
            ]
        )

        let bodyData = try JSONEncoder().encode(requestBody)

        let response = try await requestHttp(
            model: OpenAIResponse.self,
            urlString: url,
            method: "POST",
            headers: [
                ("Bearer \(apiKey)", "Authorization"),
                ("application/json", "Content-Type")
            ],
            body: bodyData
        )

        return response.choices.first?.message.content ?? "No response"
    }
}

// MARK: - OpenAI API 모델 정의
struct OpenAIRequest: Codable {
    let model: String
    let messages: [[String: String]]
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

// ✅ 사용 예시
// Task {
//     do {
//         let networkManager = NetWorkManager<OpenAIResponse>()
//         let response = try await networkManager.requestGPT4(prompt: "최신 애플 관련 기사를 정리해서 알려줘")
//         print("✅ GPT-4 응답: \(response)")
//     } catch {
//         print("❌ 오류 발생: \(error.localizedDescription)")
//     }
// }

