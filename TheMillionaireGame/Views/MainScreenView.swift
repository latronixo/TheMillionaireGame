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
                            .environmentObject(viewModel)
                    case .game:
                        GameView(currentScreen: $currentScreen)
                            .transition(.opacity)
                            .environmentObject(viewModel)
                    case .priceList:
                        PriceListView(currentScreen: $currentScreen, currentQuestion: viewModel.numberCurrentQuestion)
                            .transition(.opacity)
                            .environmentObject(viewModel)
                    case .gameOver:
                        GameOver(currentScreen: $currentScreen)
                            .transition(.opacity)
                            .environmentObject(viewModel)
                    case .rules:
                        RulesView(currentScreen: $currentScreen)
                            .transition(.opacity)
                            .environmentObject(viewModel)
                    case .audienceHelp:
                        AudienceHelp(currentScreen: $currentScreen)
                            .transition(.move(edge: .bottom))
                            .environmentObject(viewModel)
                    case .call:
                        CallView(currentScreen: $currentScreen)
                            .transition(.move(edge: .bottom))
                            .environmentObject(viewModel)
                    }
                }

            }
            .animation(.easeInOut, value: currentScreen)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .onAppear {
            // Принудительно загружаем данные при появлении view
            // например viewModel.loadData()
        }
        .onChange(of: currentScreen) { newScreen in
            if newScreen == .home {
                // Сохраняем данные при возврате на главный экран
                // например viewModel.saveData()
            }
        }
        .onDisappear {
            print("MainScreenView: Disappeared")
            // Сохраняем данные при исчезновении view
            //viewModel.saveData()
        }
    }
}

#Preview {
    MainScreenView()
}
