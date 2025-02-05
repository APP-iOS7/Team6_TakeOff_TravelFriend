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
        method: String,
        headers: [(headerValue: String, headerField: String?)] = [],
        body: Data? = nil
    ) async throws -> Model {
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        for header in headers {
            if let field = header.headerField {
                request.addValue(header.headerValue, forHTTPHeaderField: field)
            }
        }
        
        if let body = body, method == "POST" || method == "PUT" {
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        printRequest(request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("📡 HTTP 응답 상태 코드: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode != 200 {
                let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                print("❌ 서버 응답 오류: \(errorMessage) (상태 코드: \(httpResponse.statusCode))")
                
                throw NSError(domain: "OpenAI API", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
            }
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
    
    /// OpenAI API 요청을 수행하는 메서드 (에러 코드 반환 포함)
    func requestGPT4(prompt: String) async throws -> String {
        let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
        let url = "https://api.openai.com/v1/chat/completions"
        print("🔹 현재 API 키: \(apiKey.isEmpty ? "키 없음" : "키 설정됨")")
        print(apiKey)

        let requestBody = OpenAIRequest(
            model: "gpt-4o",
            messages: [
                        OpenAIRequest.Message(role: "system", content: "You are a helpful assistant."),
                        OpenAIRequest.Message(role: "user", content: prompt)
                    ]
        )
        //print("✅ 요청 모델: \(requestBody.model)")  // 요청 모델 확인 (디버깅)


        let bodyData = try JSONEncoder().encode(requestBody)
        print("📡 OpenAI 요청 본문:")
           if let requestJSON = String(data: bodyData, encoding: .utf8) {
               print(requestJSON) // ✅ 요청 본문 확인 (디버깅)
           }

        do {
            let response = try await requestHttp(
                model: OpenAIResponse.self,
                urlString: url,
                method: "POST",
                headers: [
                    ("Bearer \(apiKey)", "Authorization")
                ],
                body: bodyData
            )

            return response.choices.first?.message.content ?? "No response"
        } catch let error as URLError {
            print("❌ 네트워크 오류 발생: \(error.localizedDescription) (코드: \(error.code.rawValue))")
            throw error // 네트워크 오류 그대로 반환
        } catch let error as NSError {
            print("❌ 일반 오류 발생: \(error.localizedDescription) (도메인: \(error.domain), 코드: \(error.code))")
            throw error // NSError 오류 그대로 반환
        } catch {
            print("❌ 알 수 없는 오류 발생: \(error.localizedDescription)")
            throw error // 알 수 없는 오류 반환
        }
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

func printRequest(_ request: URLRequest) {
    print("✅ [디버깅] URLRequest 확인")
    print("- URL: \(request.url?.absoluteString ?? "URL 없음")")
    print("- HTTP Method: \(request.httpMethod ?? "메서드 없음")")
    print("- Headers: \(request.allHTTPHeaderFields ?? [:])")

    if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
        print("- Body:\n\(bodyString)")
    } else {
        print("- Body: 없음")
    }
}
