//
//  GameViewButtons.swift
//  TheMillionaireGame
//
//  Created by Валентин on 25.07.2025.
//

import SwiftUI

struct GameViewButtons: View {
    let answers: [String]
    let ABCD = ["A: ", "B: ", "C: ", "D: "]
    let answerTapped: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 70) {
            ForEach(0..<answers.count, id: \.self) { index in
                HexagonalButton(
                    text: "\(ABCD[index]) \(answers[index])",
                    color: .blue,
                    width: CGFloat(350),
                    height: CGFloat(62),
                    action: { answerTapped(index) },
                    isLeadingText: true
                )
            }
            
        }
    }
}

#Preview {
    GameViewButtons(
        answers: ["Было", "приятно", "надеюсь", "понятно"],
        answerTapped: { index in
            print("Tapped index: \(index)")
        }
    )
}
