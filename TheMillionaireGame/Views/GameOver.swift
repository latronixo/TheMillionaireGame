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
        VStack{
            Text("GAME OVER!")
            if let tookPrize = viewModel.tookMoneyPrize, let tookNumber = viewModel.tookMoneyQuestionNumber {
                Text("Вы забрали деньги на вопросе №\(tookNumber - 1)")
                Text("Ваш выигрыш: \(tookPrize)$")
            } else {
                Text("Ваш выйгрыш \(viewModel.gameOverPrize)$")
                let questionNumber = viewModel.gameOverPrizeQuestionNumber
                if questionNumber > 0 {
                    Text("Это сумма за вопрос №\(questionNumber)")
                }
            }
        }
        .onAppear() {
            viewModel.updateBestScoreIfNeede()
        }
    }
}

#Preview {
    GameOver(currentScreen: .constant(.gameOver))
        .environmentObject(QuizViewModel())
}
