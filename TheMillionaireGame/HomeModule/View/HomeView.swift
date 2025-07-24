//
//  HomeView.swift
//  TheMillionaireGame
//
//  Created by Mika on 24.07.2025.
//


import SwiftUI

struct HomeView: View {
    let level: Int?
    @StateObject private var viewModel: HomeViewModel
    @Binding var currentScreen: MainScreenDestination

    init(level: Int? = nil, currentScreen: Binding<MainScreenDestination>? = nil) {
        self.level = level
        _viewModel = StateObject(wrappedValue: HomeViewModel(level: level))
        _currentScreen = currentScreen ?? .constant(.home)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(UI.Background.name)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    logo
                    title
                    if let bestScore = viewModel.bestScore {
                        BestScoreView(score: bestScore)
                    }
                    Spacer()
                    GameButtonsView(
                        hasUnfinishedGame: viewModel.hasUnfinishedGame,
                        onNewGame: {
                        //    currentScreen = .priceList
                            currentScreen = .game
                        },
                        onContinueGame: {
                            if let quizViewModel = viewModel.savedGameViewModel {
                                quizViewModel.loadGameState()
                                //currentScreen = .priceList
                                currentScreen = .game
                            } else {
                                print("error: no saved game")
                            }
                        }
                    )
                    Spacer()
                }
                .padding()
            }
            .toolbar { helpToolbar }
        }
    }

    // MARK: - Subviews
    private var logo: some View {
        Image(UI.Background.logo)
            .resizable()
            .scaledToFit()
            .frame(width: UI.Logo.width, height: UI.Logo.height)
            .padding(.top, UI.Logo.topPadding)
    }

    private var title: some View {
        Text(UI.Title.text)
            .font(.system(size: UI.Title.fontSize, weight: UI.Title.fontWeight, design: UI.Title.fontDesign))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.top, UI.Title.topPadding)
    }

    private var helpToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { viewModel.showRulesSheet = true }) {
                Image(UI.HelpIcon.name)
                    .renderingMode(.original)
            }
        }
    }

    // MARK: - UI Constants
    private enum UI {
        enum Logo {
            static let width: CGFloat = 195
            static let height: CGFloat = 195
            static let topPadding: CGFloat = 60
        }
        enum Title {
            static let text: String = "Who Wants\nto be a Millionare"
            static let fontSize: CGFloat = 32
            static let fontWeight: Font.Weight = .semibold
            static let fontDesign: Font.Design = .default
            static let topPadding: CGFloat = 16
        }
      
        enum HelpIcon {
            static let name: String = "help"
        }
        enum Background {
            static let logo: String = "logo"
            static let name: String = "background"
        }
    }
}



// MARK: - GameButtonsView


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
