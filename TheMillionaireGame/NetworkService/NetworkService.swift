//
//  NetworkService.swift
//  TheMillionaireGame
//
//  Created by Валентин on 21.07.2025.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() {}

    private let session: URLSession = .shared
    func fetchQuestions() async throws -> [Question] {
        async let easyQuestions = fetchQuestions(for: "easy")
        async let mediumQuestions = fetchQuestions(for: "medium")
        async let hardQuestions = fetchQuestions(for: "hard")
        
        let (easy, medium, hard) = try await (easyQuestions, mediumQuestions, hardQuestions)
        return easy + medium + hard
    }
    
    private func fetchQuestions(for difficulty: String) async throws -> [Question] {
        let urlString = "https://opentdb.com/api.php?amount=5&category=11&difficulty=\(difficulty)&type=multiple&encode=url3986"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("iOSApp", forHTTPHeaderField: "User-Agent")
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode(QuestionResponse.self, from: data)
        return decodedResponse.results
    }
}
