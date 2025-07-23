//
//  RulesView.swift
//  TheMillionaireGame
//
//  Created by Chingiz on 23.07.2025.
//

import SwiftUI

struct RulesView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @Binding var currentScreen: MainScreenDestination
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.currentScreen = .home
                }) {
                    Text("Back")
                }
            }
            
            Text("Rules go here!")
        }
    }
}

#Preview {
    RulesView(currentScreen: .constant(.rules))
        .environmentObject(QuizViewModel())
}
