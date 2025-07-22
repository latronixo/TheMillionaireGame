//
//  GameView.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel: GameViewModel
    
    init(viewModel: GameViewModel = GameViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(red: 55/255, green: 76/255, blue: 148/255), Color(red: 16/255, green: 14/255, blue: 22/255)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 40){
                HeaderView()
                TimerView()
                    .environmentObject(viewModel)
                VStack(spacing: 60){
                    if viewModel.isLoading {
                        ProgressView("Loading questions...")
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        Text(viewModel.currentTextQuestion)
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .lineLimit(4)

                        VStack(alignment: .leading, spacing: 70) {
                            ForEach(0...3, id: \.self) { index in
                                Button {
                                    viewModel.nextQuestion()
                                } label: {
                                    Text("\(viewModel.ABCD[index]) \(viewModel.answers[index])")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            
                        }
                    }
                }
                Spacer()
            }
        }
        .task {
            await viewModel.loadQuestions()
        }
    }
}

#Preview{
    //GameView()
    let mockViewModel = GameViewModel()
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
    
    return GameView(viewModel: mockViewModel)
}
