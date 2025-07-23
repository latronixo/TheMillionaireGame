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
        Text("GAME OVER!")
    }
}

#Preview {
    GameOver(currentScreen: .constant(.gameOver))
        .environmentObject(QuizViewModel())
}
