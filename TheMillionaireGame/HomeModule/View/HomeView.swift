//
//  HomeView.swift
//  TheMillionaireGame
//
//  Created by Mika on 24.07.2025.
//


import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var currentScreen: MainScreenDestination

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
                    BestScoreView()
                    Spacer()
                    ButtonsView(
                        hasUnfinishedGame: viewModel.hasUnfinishedGame,
                        onNewGame: {
                            viewModel.startNewGame()
                            currentScreen = .game
                        },
                        onContinueGame: {
                            viewModel.continueGame()
                            currentScreen = .game
                        }
                    )
                    Spacer()
                }
                .padding()
            }
            .toolbar { helpToolbar }
            .onAppear {
                viewModel.loadSavedGame()
            }
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
            Button(action: {
                currentScreen = .rules
            }) {
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




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        // Мокаем MainScreenDestination и HomeViewModel для превью
        HomeView(currentScreen: .constant(.home))
            .environmentObject(HomeViewModel())
    }
}
