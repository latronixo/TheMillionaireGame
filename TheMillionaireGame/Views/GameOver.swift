//
//  GameOver.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 24.07.2025.
//

import SwiftUI

struct GameOver: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @Binding var currentScreen: MainScreenDestination
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                VStack {
                    logo
                    title
                    
                    if let tookPrize = viewModel.tookMoneyPrize,
                       let tookNumber = viewModel.tookMoneyQuestionNumber {
                        
//                        if let tookPrize = viewModel.tookMoneyPrize, let tookNumber = viewModel.tookMoneyQuestionNumber {
//                            Text("Вы забрали деньги на вопросе №\(tookNumber - 1)")
//                            Text("Ваш выигрыш: \(tookPrize)$")
//                        } else {
//                            Text("Ваш выйгрыш \(viewModel.gameOverPrize)$")
//                            let questionNumber = viewModel.gameOverPrizeQuestionNumber
//                            if questionNumber > 0 {
//                                Text("Это сумма за вопрос №\(questionNumber)")
//                            }
                        
                        Text(UI.GameOver.Level.text + " \(tookNumber - 1)")
                            .font(.system(size: UI.GameOver.Level.fontSize, weight: UI.GameOver.Level.fontWeight, design: UI.GameOver.Level.fontDesign))
                            .foregroundColor(.white)
                            .opacity(UI.GameOver.Level.opacity)
                            .multilineTextAlignment(.center)
                            .padding(.top, UI.GameOver.Level.topPadding)
                        HStack {
                            Spacer()
                           coin
                            Text("\(tookPrize)")
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
                            currentScreen = .game
                        }, onMainScreen: {
                            currentScreen = .home
                        }
                    )
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    // MARK: - Subviews
    private var background: some View {
        Image(UI.Background.name)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    private var logo: some View {
        Image(UI.Background.logo)
            .resizable()
            .scaledToFit()
            .frame(width: UI.Logo.width, height: UI.Logo.height)
            .padding(.top, UI.Logo.topPadding)
    }
    
    private var title: some View {
        Text(UI.GameOver.Title.text)
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
        enum Background {
            static let logo: String = "logo"
            static let name: String = "background"
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
//        .onAppear() {
//            viewModel.updateBestScoreIfNeede()
//        }
    }
}




struct GameOverButtonsView: View {
    let onNewGame: () -> Void
    let onMainScreen: () -> Void
    var body: some View {
        VStack(spacing: 0) {
            HexagonalButton(
                text: UI.Button.newGameText,
                color: UI.Button.newGameColor,
                width: UI.Button.width,
                height: UI.Button.height,
                action: onNewGame,
                isLeadingText: false
            )
            HexagonalButton(
                text: UI.Button.mainScreenText,
                color: UI.Button.mainScreenColor,
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
            static let newGameColor: Color = .yellow
            static let mainScreenText: String = "Main screen"
            static let mainScreenColor: Color = .blue
            static let width: CGFloat = 350
            static let height: CGFloat = 62
            static let mainScreenTopPadding: CGFloat = 8
        }
    }
}




#Preview {
    GameOver(currentScreen: .constant(.gameOver))
        .environmentObject(QuizViewModel())
}
