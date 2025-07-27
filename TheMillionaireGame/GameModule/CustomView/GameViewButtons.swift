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
    
    private let defaultGradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(hex: "#025D83"), location: 0.0),
            .init(color: Color(hex: "#022B54"), location: 0.3333),
            .init(color: Color(hex: "#020631"), location: 0.7969),
            .init(color: Color(hex: "#083C66"), location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    private let selectedGradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(hex: "#E1CF30"), location: 0.0),
            .init(color: Color(hex: "#E19A30"), location: 0.3333),
            .init(color: Color(hex: "#E19A30"), location: 0.7969),
            .init(color: Color(hex: "#E1CF30"), location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    private let correctGradient = LinearGradient(
        gradient: Gradient(colors: [.green, .darkGreen]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    private let incorrectGradient = LinearGradient(
        gradient: Gradient(colors: [.red, .darkRed]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(0..<answers.count, id: \.self) { index in
                HexagonalButton(
                    text: "\(ABCD[index]) \(answers[index])",
                    gradient: buttonGradient(for: index),
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
    
    private func buttonGradient(for index: Int) -> LinearGradient {
        if let selected = selectedIndex {
            if !showCorrectOrNot {
                return index == selected ? selectedGradient : defaultGradient
            } else {
                if index == correctAnswerIndex {
                    return correctGradient
                } else if index == selected {
                    return incorrectGradient
                } else {
                    return defaultGradient
                }
            }
        } else {
            return defaultGradient
        }
    }
}

extension Color {
    static let darkGreen = Color(hex: "#006400")
    static let darkRed = Color(hex: "#8B0000")
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
