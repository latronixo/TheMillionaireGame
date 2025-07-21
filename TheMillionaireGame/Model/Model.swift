//
//  Model.swift
//  TheMillionaireGame
//
//  Created by Валентин on 20.07.2025.
//

import Foundation

struct QuestionResponse: Decodable {
    let results: [Question]
}

struct Question: Decodable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case type
        case difficulty
        case category
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
