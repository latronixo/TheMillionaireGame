//
//  GameButtonsView.swift
//  TheMillionaireGame
//
//  Created by Mika on 24.07.2025.
//

import SwiftUI

struct ButtonsView: View {
    let hasUnfinishedGame: Bool
    let onNewGame: () -> Void
    let onContinueGame: () -> Void
    
    private let yellowGradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(hex: "#E1CF30"), location: 0.0),
            .init(color: Color(hex: "#E19A30"), location: 0.3333),
            .init(color: Color(hex: "#E19A30"), location: 0.7969),
            .init(color: Color(hex: "#E1CF30"), location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    private let blueGradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(hex: "#025D83"), location: 0.0),
            .init(color: Color(hex: "#022B54"), location: 0.3333),
            .init(color: Color(hex: "#020631"), location: 0.7969),
            .init(color: Color(hex: "#083C66"), location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        VStack(spacing: 0) {
            HexagonalButton(
                text: UI.Button.newGameText,
                gradient: yellowGradient,
                width: UI.Button.width,
                height: UI.Button.height,
                action: onNewGame,
                isLeadingText: false
            )
            if hasUnfinishedGame {
                HexagonalButton(
                    text: UI.Button.continueGameText,
                    gradient: blueGradient,
                    width: UI.Button.width,
                    height: UI.Button.height,
                    action: onContinueGame,
                    isLeadingText: false
                )
                .padding(.top, UI.Button.continueTopPadding)
            }
        }
    }
    
    private enum UI {
        enum Button {
            static let newGameText: String = "New game"
            static let continueGameText: String = "Continue game"
            static let width: CGFloat = 350
            static let height: CGFloat = 62
            static let continueTopPadding: CGFloat = 8
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
