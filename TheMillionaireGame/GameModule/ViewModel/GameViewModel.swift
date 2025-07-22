//
//  GameViewModel.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var currentTextQuestion = ""
    @Published var numberCurrentQuestion = -1
    @Published var answers = ["", "", "", ""]
    @Published var correctAnswer = ""
    let ABCD = ["A: ", "B: ", "C: ", "D: "]

    func loadQuestions() async {
        await MainActor.run { self.isLoading = true }
        await MainActor.run { self.errorMessage = nil }
        
        do {
            let questions = try await NetworkService.shared.fetchQuestions()
            await MainActor.run {
                self.questions = questions
                self.saveQuestionsToUserDefaults(questions)
                self.nextQuestion()
                self.isLoading = false
            }
        } catch {
            if let cachedQuestions = self.loadQuestionsFromUserDefaults() {
                await MainActor.run {
                    self.questions = cachedQuestions
                    self.nextQuestion()
                    self.isLoading = false
                }
            } else {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func saveQuestionsToUserDefaults(_ questions: [Question]) {
        if let data = try? JSONEncoder().encode(questions) {
            UserDefaults.standard.set(data, forKey: "cachedQuestions")
        }
    }
    
    func loadQuestionsFromUserDefaults() -> [Question]? {
        if let data = UserDefaults.standard.data(forKey: "cachedQuestions"), let questions = try? JSONDecoder().decode([Question].self, from: data) {
            return questions
        }
        return nil
    }
    
    func nextQuestion() {
        if numberCurrentQuestion < 14 {
            numberCurrentQuestion += 1
            print("numberCurrentQuestion = \(numberCurrentQuestion)")
            currentTextQuestion = questions[numberCurrentQuestion].question
            correctAnswer = questions[numberCurrentQuestion].correctAnswer
            answers = ([correctAnswer] + questions[numberCurrentQuestion].incorrectAnswers).shuffled()
        }
    }
    
    //MARK: - Change BackgroundColor in Timer
    
    func setBackground(time: Double, totalTime: Double) -> Color {
        if time <= 5 {
            return .red.opacity(0.8)
        } else if time <= totalTime / 2 {
            return .yellow.opacity(0.5)
        } else {
            return .white.opacity(0.3)
        }
    }
}
