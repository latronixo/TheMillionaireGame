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
    @StateObject private var soundManager = SoundManager.shared
    @State private var showAnswerResult = false
    @State private var isAnswerCorrect = false

    
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
                            
                            GameViewButtons(answers: viewModel.answers, correctAnswerIndex: viewModel.answers.firstIndex(of: viewModel.correctAnswer) ?? 0) { index in
                                viewModel.shouldStopTimer = true
                                
                                let isCorrect = viewModel.answers[index] == viewModel.correctAnswer
                                isAnswerCorrect = isCorrect
                                
                                // Показываем результат
                                showAnswerResult = true
                                
                                // Обрабатываем ответ
                                viewModel.answerTapped(index)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    showAnswerResult = false
                                    if isCorrect && viewModel.numberCurrentQuestion < 15 {
                                        currentScreen = .priceList
                                    } else {
                                        currentScreen = .gameOver
                                    }
                                }
                                
                            }
                            .environmentObject(viewModel)
                        }
                    }
                    // кнопки подсказок:
                    HStack (spacing: geo.width * 0.08) {
                        Button {
                            viewModel.fiftyHintWasUsed = true                          
                            viewModel.fiftyFifty()
                        } label: {
                            Image("fiftyRemove")
                            .opacity(viewModel.fiftyHintWasUsed ? 0.4 : 1.0)
                        }
                        .disabled(viewModel.fiftyHintWasUsed)
                        
                        Button {
                            viewModel.audienceHelpHintWasUsed = true
                            currentScreen = .audienceHelp
                            viewModel.priceOrHintScreenIsShown = true
                        } label: {
                            Image("audience")
                            .opacity(viewModel.audienceHelpHintWasUsed ? 0.4 : 1.0)
                        }
                        .disabled(viewModel.audienceHelpHintWasUsed)
                        
                        Button {
                            viewModel.callHintWasUsed = true
                            currentScreen = .call
                            viewModel.priceOrHintScreenIsShown = true
                        } label: {
                            Image("call")
                            .opacity(viewModel.callHintWasUsed ? 0.4 : 1.0)
                        }
                        .disabled(viewModel.callHintWasUsed)
                    }
                }
                .onChange(of: viewModel.isLoading) { isLoading in
                    if !isLoading {
                        viewModel.startTimer()
                    }
                }
                .onChange(of: viewModel.timeRemaining) { remaining in
                    if remaining == 0 {
                        viewModel.stopTimer()
                        viewModel.saveGameState(numberQuestion: nil)
                        currentScreen = .gameOver
                    }
                }
            }
        }
        .onAppear {
            soundManager.playSound("clockTicking", loop: true)
        }
        .onDisappear {
            soundManager.stopSound("clockTicking")
        }
    }
}


#Preview{
    GameView(currentScreen: .constant(.game))
        .environmentObject(QuizViewModel())
}
