import SwiftUI

struct HomeView: View {
    let level: Int?
    @StateObject private var viewModel: HomeViewModel
   // @EnvironmentObject var viewModel: QuizViewModel
    @Binding var currentScreen: MainScreenDestination
//    @State private var showGameView = false
//    @State private var showContinueGameView = false
//    @State private var showRules = false
//
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
                    Image(UI.Background.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UI.Logo.width, height: UI.Logo.height)
                        .padding(.top, UI.Logo.topPadding)
                    
                    if viewModel.isGameOverView {
                        Text(UI.GameOver.Title.text)
                            .font(.system(size: UI.GameOver.Title.fontSize, weight: UI.GameOver.Title.fontWeight, design: UI.GameOver.Title.fontDesign))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, UI.GameOver.Title.topPadding)
                    } else {
                        Text(UI.Title.text)
                            .font(.system(size: UI.Title.fontSize, weight: UI.Title.fontWeight, design: UI.Title.fontDesign))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, UI.Title.topPadding)
                    }
                 // todo - amount тут может быть нил?
                    if viewModel.isGameOverView, let amount = viewModel.winAmount {
                        Text(UI.GameOver.Level.text + " \(viewModel.level ?? 0)")
                            .font(.system(size: UI.GameOver.Level.fontSize, weight: UI.GameOver.Level.fontWeight, design: UI.GameOver.Level.fontDesign))
                            .foregroundColor(.white)
                            .opacity(UI.GameOver.Level.opacity)
                            .multilineTextAlignment(.center)
                            .padding(.top, UI.GameOver.Level.topPadding)
                        HStack {
                            Spacer()
                            Image(UI.Coin.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UI.Coin.width, height: UI.Coin.height)
                            Text("\(amount)")
                                .font(.system(size: UI.Score.fontSize, weight: UI.Score.fontWeight, design: UI.Score.fontDesign))
                                .foregroundColor(.white)
                            Spacer()
                        }
                    } else {
                        if let bestScore = viewModel.bestScore {
                            Text(UI.BestScore.text)
                                .font(.system(size: UI.BestScore.fontSize, weight: UI.BestScore.fontWeight, design: UI.BestScore.fontDesign))
                                .foregroundColor(.white)
                                .opacity(UI.BestScore.opacity)
                                .multilineTextAlignment(.center)
                                .padding(.top, UI.BestScore.topPadding)
                            HStack {
                                Spacer()
                                Image(UI.Coin.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UI.Coin.width, height: UI.Coin.height)
                                Text("\(bestScore)")
                                    .font(.system(size: UI.Score.fontSize, weight: UI.Score.fontWeight, design: UI.Score.fontDesign))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                    HexagonalButton(
                        text: UI.Button.newGameText,
                        color: UI.Button.newGameColor,
                        width: UI.Button.width,
                        height: UI.Button.height,
                        action: {
        //                    viewModel.startNewGame()
                            currentScreen = .priceList
                        },
                        isLeadingText: false
                    )
                    if viewModel.hasUnfinishedGame {
                        HexagonalButton(
                            text: UI.Button.continueGameText,
                            color: UI.Button.continueGameColor,
                            width: UI.Button.width,
                            height: UI.Button.height,
                            action: { viewModel.continueGame() },
                            isLeadingText: false
                        )
                        .padding(.top, UI.Button.continueTopPadding)
                    }
                    Spacer()
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {

                   // Button(action: { viewModel.showRulesSheet = true }) {

                    Button(action: {
                        currentScreen = .rules
                    }) {
                        Image(UI.HelpIcon.name)
                            .renderingMode(.original)
                    }
                }
            }

//            .sheet(isPresented: $viewModel.showRulesSheet) {
//                RulesView()
//            }
//            .navigationDestination(isPresented: $viewModel.showGameView) {
//                PriceListView(currentQuestion: 1)
//            }
//            .navigationDestination(isPresented: $viewModel.hasUnfinishedGame) {
//                GameView()
//            }
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
    enum BestScore {
        static let text: String = "All-time Best Score"
        static let fontSize: CGFloat = 16
        static let fontWeight: Font.Weight = .medium
        static let fontDesign: Font.Design = .default
        static let opacity: Double = 0.5
        static let topPadding: CGFloat = 16
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
    enum Button {
        static let newGameText: String = "New game"
        static let newGameColor: Color = .yellow
        static let continueGameText: String = "Continue game"
        static let continueGameColor: Color = .blue
        static let width: CGFloat = 350
        static let height: CGFloat = 62
        static let continueTopPadding: CGFloat = 8
    }
    enum HelpIcon {
        static let name: String = "help"
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
