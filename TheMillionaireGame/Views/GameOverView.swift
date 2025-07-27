//
//  GameOver.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 24.07.2025.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var currentScreen: MainScreenDestination
    @StateObject private var soundManager = SoundManager.shared

    private var sayGoodBayPhrase: String {
        if viewModel.gameOverPrizeQuestionNumber == 15 {
            return "YOU WIN!"
        } else {
            return "GAME OVER"
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {
                    LogoView(size: CGSize(width: UI.Logo.width, height: UI.Logo.height))
                                            .padding(.top, UI.Logo.topPadding)
                    title
                    
                    if let tookPrize = viewModel.tookMoneyPrize,
                       let tookNumber = viewModel.tookMoneyQuestionNumber {
                        Text(UI.GameOver.Level.text + " \(tookNumber)")
                            .font(.system(size: UI.GameOver.Level.fontSize, weight: UI.GameOver.Level.fontWeight, design: UI.GameOver.Level.fontDesign))
                            .foregroundColor(.white)
                            .opacity(UI.GameOver.Level.opacity)
                            .multilineTextAlignment(.center)
                            .padding(.top, UI.GameOver.Level.topPadding)
                        HStack {
                            Spacer()
                           coin
                            Text("$\(tookPrize.formatted(.number.locale(Locale(identifier: "en_US"))))")
                                .font(.system(size: UI.Score.fontSize, weight: UI.Score.fontWeight, design: UI.Score.fontDesign))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                    } else {
                        
                        Text(UI.GameOver.Level.text + " \(viewModel.gameOverPrizeQuestionNumber)")
                            .font(.system(size: UI.GameOver.Level.fontSize, weight: UI.GameOver.Level.fontWeight, design: UI.GameOver.Level.fontDesign))
                            .foregroundColor(.white)
                            .opacity(UI.GameOver.Level.opacity)
                            .multilineTextAlignment(.center)
                            .padding(.top, UI.GameOver.Level.topPadding)
                        HStack {
                            Spacer()
                            coin
                            Text("\(viewModel.gameOverPrize)")
                                .font(.system(size: UI.Score.fontSize, weight: UI.Score.fontWeight, design: UI.Score.fontDesign))
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    
                    
                    Spacer()
                    GameOverButtonsView(
                        onNewGame: {
                            homeViewModel.startNewGame()
                            currentScreen = .game
                        }, onMainScreen: {
                            currentScreen = .home
                        }
                    )
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                viewModel.updateBestScoreIfNeeded()
                soundManager.playSound("wrongAnswer")
            }
            .onDisappear {
                soundManager.stopSound("wrongAnswer")
            }
        }
    }
    
    // MARK: - Subviews
    
    private var title: some View {
        Text(sayGoodBayPhrase)
            .font(.system(size: UI.GameOver.Title.fontSize, weight: UI.GameOver.Title.fontWeight, design: UI.GameOver.Title.fontDesign))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.top, UI.GameOver.Title.topPadding)
        
    }
    private var coin: some View {
        Image(UI.Coin.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: UI.Coin.width, height: UI.Coin.height)
    }
    
    // MARK: - UI Constants
    private enum UI {
        enum Logo {
            static let width: CGFloat = 195
            static let height: CGFloat = 195
            static let topPadding: CGFloat = 60
        }
        enum Coin {
            static let imageName: String = "coin"
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
        enum Score {
            static let fontSize: CGFloat = 24
            static let fontWeight: Font.Weight = .semibold
            static let fontDesign: Font.Design = .default
        }
        enum GameOver {
            enum Title {
                static let text: String = "GAME OVER"
                static let fontSize: CGFloat = 32
                static let fontWeight: Font.Weight = .semibold
                static let fontDesign: Font.Design = .default
                static let topPadding: CGFloat = 16
            }
            enum Level {
                static let text: String = "Level:"
                static let fontSize: CGFloat = 16
                static let fontWeight: Font.Weight = .medium
                static let fontDesign: Font.Design = .default
                static let opacity: Double = 0.5
                static let topPadding: CGFloat = 16
            }
        }
    }
}




struct GameOverButtonsView: View {
    let onNewGame: () -> Void
    let onMainScreen: () -> Void
    
    // Градиент для желтой кнопки
    private let yellowGradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(hex: "#E1CF30"), location: 0.0),
            .init(color: Color(hex: "#E19A30"), location: 0.3333),
            .init(color: Color(hex: "#E19A30"), location: 0.7969),
            .init(color: Color(hex: "#E1CF30"), location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    // Градиент для синей кнопки
    private let blueGradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(hex: "#025D83"), location: 0.0),
            .init(color: Color(hex: "#022B54"), location: 0.3333),
            .init(color: Color(hex: "#020631"), location: 0.7969),
            .init(color: Color(hex: "#083C66"), location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        VStack(spacing: 0) {
            HexagonalButton(
                text: UI.Button.newGameText,
                gradient: yellowGradient, // Используем градиент вместо цвета
                width: UI.Button.width,
                height: UI.Button.height,
                action: onNewGame,
                isLeadingText: false
            )
            HexagonalButton(
                text: UI.Button.mainScreenText,
                gradient: blueGradient, // Используем градиент вместо цвета
                width: UI.Button.width,
                height: UI.Button.height,
                action: onMainScreen,
                isLeadingText: false
            )
            .padding(.top, UI.Button.mainScreenTopPadding)
        }
    }
    
    private enum UI {
        enum Button {
            static let newGameText: String = "New game"
            static let mainScreenText: String = "Main screen"
            static let width: CGFloat = 350
            static let height: CGFloat = 62
            static let mainScreenTopPadding: CGFloat = 8
        }
    }
}



#Preview {
    GameOverView(currentScreen: .constant(.gameOver))
        .environmentObject(QuizViewModel())
}
