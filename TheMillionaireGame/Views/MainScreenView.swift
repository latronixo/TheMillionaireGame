//
//  MainScreenView.swift
//  TheMillionaireGame
//
//  Created by Валентин on 20.07.2025.
//

import SwiftUI

enum MainScreenDestination {
    case home
    case game
    case rules
    case priceList
    case gameOver
    case audienceHelp
    case call
}

struct MainScreenView: View {
    @StateObject private var viewModel = QuizViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @State private var showGameView = false
    @State private var currentScreen: MainScreenDestination = .home
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    switch currentScreen {
                    case .home:
                        HomeView(currentScreen: $currentScreen)
                            .transition(.opacity)
                            .environmentObject(homeViewModel)
                    case .game:
                        if let quizVM = homeViewModel.savedGameViewModel {
                            GameView(currentScreen: $currentScreen)
                                .transition(.opacity)
                                .environmentObject(quizVM)
                        } else {
                            //fallback, если нет сохраненной игры
                            GameView(currentScreen: $currentScreen)
                                .transition(.opacity)
                                .environmentObject(QuizViewModel())
                        }
                    case .priceList:
                        if let quizVM = homeViewModel.savedGameViewModel {
                                PriceListView(currentScreen: $currentScreen, currentQuestion: quizVM.numberCurrentQuestion)
                                    .transition(.opacity)
                                    .environmentObject(quizVM)
                            } else {
                                PriceListView(currentScreen: $currentScreen, currentQuestion: 0)
                                    .transition(.opacity)
                                    .environmentObject(QuizViewModel())
                            }
                    case .gameOver:
                        if let quizVM = homeViewModel.savedGameViewModel {
                            GameOverView(currentScreen: $currentScreen)
                                .transition(.opacity)
                                .environmentObject(quizVM)
                                .environmentObject(homeViewModel)
                        } else {
                            GameOverView(currentScreen: $currentScreen)
                                .transition(.opacity)
                                .environmentObject(QuizViewModel())
                                .environmentObject(homeViewModel)
                        }
                    case .rules:
                        RulesView(currentScreen: $currentScreen)
                            .transition(.opacity)
                            .environmentObject(homeViewModel)
                    case .audienceHelp:
                        if let quizVM = homeViewModel.savedGameViewModel {
                             AudienceHelpView(currentScreen: $currentScreen)
                                 .transition(.move(edge: .bottom))
                                 .environmentObject(quizVM)
                         } else {
                             AudienceHelpView(currentScreen: $currentScreen)
                                 .transition(.move(edge: .bottom))
                                 .environmentObject(QuizViewModel())
                         }
                    case .call:
                        if let quizVM = homeViewModel.savedGameViewModel {
                                CallView(currentScreen: $currentScreen)
                                    .transition(.move(edge: .bottom))
                                    .environmentObject(quizVM)
                            } else {
                                CallView(currentScreen: $currentScreen)
                                    .transition(.move(edge: .bottom))
                                    .environmentObject(QuizViewModel())
                            }
                    }
                }

            }
            .animation(.easeInOut, value: currentScreen)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .onAppear {
            // Принудительно загружаем данные при появлении view
            viewModel.loadGameState()
        }
        .onChange(of: currentScreen) { newScreen in
            if newScreen == .home {
                // Сохраняем данные при возврате на главный экран
                viewModel.saveGameState(numberQuestion: viewModel.numberCurrentQuestion)
                homeViewModel.loadSavedGame()
            }
        }
        .onDisappear {
            print("MainScreenView: Disappeared")
            // Сохраняем данные при исчезновении view
            viewModel.saveGameState(numberQuestion: viewModel.numberCurrentQuestion)
        }
    }
}

#Preview {
    MainScreenView()
}
