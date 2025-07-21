//
//  GameViewModel.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import Foundation

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
                self.nextQuestion()
                self.isLoading = false
            }
        } catch {
            await MainActor.run { self.errorMessage = error.localizedDescription }
        }
    }
    
    func nextQuestion() {
        numberCurrentQuestion += 1
        print("numberCurrentQuestion = \(numberCurrentQuestion)")
        currentTextQuestion = questions[numberCurrentQuestion].question
        correctAnswer = questions[numberCurrentQuestion].correctAnswer
        answers = ([correctAnswer] + questions[numberCurrentQuestion].incorrectAnswers).shuffled()
    }
}
