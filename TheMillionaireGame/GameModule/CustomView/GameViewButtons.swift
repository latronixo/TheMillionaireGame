//
//  GameViewButtons.swift
//  TheMillionaireGame
//
//  Created by Валентин on 25.07.2025.
//

import SwiftUI

struct GameViewButtons: View {
    
    let answers: [String]
    let correctAnswerIndex: Int
    let answerTapped: (Int) -> Void
    private let ABCD = ["A: ", "B: ", "C: ", "D: "]

    @State private var selectedIndex: Int? = nil
    @State private var showCorrectOrNot = false
    @EnvironmentObject var vm: QuizViewModel
    @EnvironmentObject var soundManager: SoundManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(0..<answers.count, id: \.self) { index in
                HexagonalButton(
                    text: "\(ABCD[index]) \(answers[index])",
                    color: buttonColor(for: index),
                    width: CGFloat(350),
                    height: CGFloat(62),
                    action: {
                        guard selectedIndex == nil else { return }
                        
                        // 1. Останавливаем таймер и звук часов
                        vm.shouldStopTimer = true
                        soundManager.stopSound("clockTicking")
                        
                        // 2. Запускаем звук принятия ответа
                        soundManager.playSound("acceptedAnswer")
                        
                        // 3. Запоминаем выбранный ответ
                        withAnimation {
                            selectedIndex = index
                        }
                        
                        // 4. Вызываем обработчик ответа
                        answerTapped(index)
                        
                        // 5. Через 5 секунд показываем правильность ответа
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                showCorrectOrNot = true
                                let isCorrect = index == correctAnswerIndex
                                if isCorrect {
                                    soundManager.playSound("correctAnswer")
                                } else {
                                    soundManager.playSound("wrongAnswer")
                                }
                            }
                        }
                    },
                    isLeadingText: true
                )
                .disabled(selectedIndex != nil)
            }
        }
        .onDisappear {
            soundManager.stopSound("acceptedAnswer")
        }
    }
    
    private func buttonColor(for index: Int) -> Color {
          if let selected = selectedIndex {
              if !showCorrectOrNot {
                  return index == selected ? .gold : .navy
              } else {
                  if index == correctAnswerIndex {
                      return .grassGreen
                  } else if index == selected {
                      return .red
                  } else {
                      return .navy
                  }
              }
          } else {
              return .navy
          }
      }
}

#Preview {
    GameViewButtons(
        answers: ["Было", "приятно", "надеюсь", "понятно"],
        correctAnswerIndex: 1,
        answerTapped: { index in
            print("Tapped index: \(index)")
        }
    )
    .environmentObject(QuizViewModel())
    .environmentObject(SoundManager.shared)
}
