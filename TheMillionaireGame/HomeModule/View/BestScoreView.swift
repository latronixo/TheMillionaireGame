//
//  BestScoreView.swift
//  TheMillionaireGame
//
//  Created by Mika on 24.07.2025.
//

import SwiftUI


struct BestScoreView: View {
    @State private var bestScore: Int = UserDefaults.standard.integer(forKey: "bestScore")
    
    var body: some View {
        VStack(spacing: 0) {
            Text(UI.BestScore.text)
                .font(.system(
                    size: UI.BestScore.fontSize,
                    weight: UI.BestScore.fontWeight,
                    design: UI.BestScore.fontDesign)
                )
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
                Text("$\(bestScore)")
                    .font(.system(
                        size: UI.Score.fontSize,
                        weight: UI.Score.fontWeight,
                        design: UI.Score.fontDesign))
                    .foregroundColor(.white)
                    .onAppear {
                        bestScore = UserDefaults.standard.integer(forKey: "bestScore")
                    }
                Spacer()
            }
        }
    }
    
    private enum UI {
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
    }
}
