//
//  GameView.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @Binding var currentScreen: MainScreenDestination

    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(red: 55/255, green: 76/255, blue: 148/255), Color(red: 16/255, green: 14/255, blue: 22/255)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 40){
                HeaderView(currentScreen: $currentScreen)
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
                                    viewModel.answerTapped(index)
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
        .task(id: viewModel.questions) {
            if viewModel.questions.isEmpty {
                await viewModel.loadQuestions()
            }
        }
    }
}

#Preview{
    GameView(currentScreen: .constant(.game))
        .environmentObject(QuizViewModel())
}
