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
            
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 40){
                    HeaderView(currentScreen: $currentScreen)
                    TimerView()
                        .environmentObject(viewModel)
                    VStack(spacing: 60) {
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
                            
                            GameViewButtons(answers: viewModel.answers, correctAnswerIndex: viewModel.answers.firstIndex(of: viewModel.correctAnswer) ?? -1) { index in
                                viewModel.answerTapped(index)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                    currentScreen = .priceList
                                }
                                
                            }
                        }
                    }
                    .task(id: viewModel.questions) {
                        if viewModel.questions.isEmpty {
                            await viewModel.loadQuestions()
                        }
                    }
                    HStack (spacing: geo.width * 0.08) {
                        Button {
                            print("--> tapped 50:50")
                        } label: {
                            Image("fiftyRemove")
                        }
                        
                        
                        Button {
                            currentScreen = .audienceHelp
                        } label: {
                            Image("audience")
                        }
                        
                        
                        Button {
                            print("--> tapped call friend")
                        } label: {
                            Image("call")
                        }
                        
                    }
                    
                }
            }
        }
    }
}


#Preview{
    GameView(currentScreen: .constant(.game))
        .environmentObject(QuizViewModel())
}
