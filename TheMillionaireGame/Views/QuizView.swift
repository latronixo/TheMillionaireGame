//
//  QuizView.swift
//  TheMillionaireGame
//
//  Created by Валентин on 21.07.2025.
//

import SwiftUI

struct QuizView: View {
    @StateObject private var viewModel: QuizViewModel
    
    init(viewModel: QuizViewModel = QuizViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Questions...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(viewModel.questions.indices, id: \.self) { index in
                        let question = viewModel.questions[index]
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(index + 1). \(question.question.removingPercentEncoding ?? question.question)")
                                .font(.headline)
                            Text("Difficulty: \(question.difficulty.capitalized)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Quiz Questions")
            .task {
                await viewModel.loadQuestions()
            }
        }
    }
}

#Preview {
    let mockViewModel = QuizViewModel()
    mockViewModel.questions = [
        Question(
            type: "multiple",
            difficulty: "easy",
            category: "Entertainment: Film",
            question: "What is the name of the protagonist in 'Cast Away'?",
            correctAnswer: "Wilson",
            incorrectAnswers: ["Carson", "Jackson", "Willy"]
        ),
        Question(
            type: "multiple",
            difficulty: "medium",
            category: "Entertainment: Film",
            question: "Which movie was NOT released in 1996?",
            correctAnswer: "Gladiator",
            incorrectAnswers: ["Independence Day", "The Rock", "Mission: Impossible"]
        ),
        Question(
            type: "multiple",
            difficulty: "hard",
            category: "Entertainment: Film",
            question: "Which animated movie first featured a celebrity voice actor?",
            correctAnswer: "Aladdin",
            incorrectAnswers: ["Toy Story", "James and the Giant Peach", "The Hunchback of Notre Dame"]
        )
    ]
    mockViewModel.isLoading = false
    
    return QuizView(viewModel: mockViewModel)
}
