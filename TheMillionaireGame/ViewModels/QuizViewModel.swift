//
//  QuizViewModel.swift
//  TheMillionaireGame
//
//  Created by Валентин on 21.07.2025.
//

import Foundation

final class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func loadQuestions() async {
        await MainActor.run { self.isLoading = true }
        await MainActor.run { self.errorMessage = nil }
        
        do {
            let questions = try await NetworkService.shared.fetchQuestions()
            await MainActor.run { self.questions = questions }
        } catch {
            await MainActor.run { self.errorMessage = error.localizedDescription }
        }
        
        await MainActor.run { self.isLoading = false }
    }
}
