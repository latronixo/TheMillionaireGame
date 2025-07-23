import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: QuizViewModel
    @Binding var currentScreen: MainScreenDestination
    
    @State private var showGameView = false
    @State private var showContinueGameView = false
    @State private var showRules = false
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
            static let text: String = "15,000"
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
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UI.Logo.width, height: UI.Logo.height)
                        .padding(.top, UI.Logo.topPadding)
                    
                    Text(UI.Title.text)
                        .font(.system(size: UI.Title.fontSize, weight: UI.Title.fontWeight, design: UI.Title.fontDesign))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, UI.Title.topPadding)
                    
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
                        
                        Text(UI.Score.text)
                            .font(.system(size: UI.Score.fontSize, weight: UI.Score.fontWeight, design: UI.Score.fontDesign))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    Spacer()
                    HexagonalButton(
                        text: UI.Button.continueGameText,
                        color: UI.Button.continueGameColor,
                        width: UI.Button.width,
                        height: UI.Button.height,
                        action: {
                            showContinueGameView = true
                        },
                        isLeadingText: false
                    )
                    HexagonalButton(
                        text: UI.Button.newGameText,
                        color: UI.Button.newGameColor,
                        width: UI.Button.width,
                        height: UI.Button.height,
                        action: {
                            currentScreen = .priceList
                        },
                        isLeadingText: false
                    )
                    .padding(.top, UI.Button.continueTopPadding)
                    Spacer()
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        currentScreen = .rules
                    }) {
                        Image(UI.HelpIcon.name)
                            .renderingMode(.original)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentScreen: .constant(.home))
            .environmentObject(QuizViewModel())
    }
} 
