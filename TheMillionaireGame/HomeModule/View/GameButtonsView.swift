//
//  GameButtonsView.swift
//  TheMillionaireGame
//
//  Created by Mika on 24.07.2025.
//

import SwiftUI

struct GameButtonsView: View {
    let hasUnfinishedGame: Bool
    let onNewGame: () -> Void
    let onContinueGame: () -> Void
    var body: some View {
        VStack(spacing: 0) {
            HexagonalButton(
                text: UI.Button.newGameText,
                color: UI.Button.newGameColor,
                width: UI.Button.width,
                height: UI.Button.height,
                action: onNewGame,
                isLeadingText: false
            )
            if hasUnfinishedGame {
                HexagonalButton(
                    text: UI.Button.continueGameText,
                    color: UI.Button.continueGameColor,
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
            static let newGameColor: Color = .yellow
            static let continueGameText: String = "Continue game"
            static let continueGameColor: Color = .blue
            static let width: CGFloat = 350
            static let height: CGFloat = 62
            static let continueTopPadding: CGFloat = 8
        }
    }
}
