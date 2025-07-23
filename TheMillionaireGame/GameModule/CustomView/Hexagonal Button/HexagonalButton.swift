//
//  HexagonalButton.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 21.07.2025.
//

import SwiftUI

/// Переиспользуемая шестиугольная кнопка с кастомным инициализатором
///
/// - Параметры:
///     - isLeadingText - там где необходимо использовать кнопку в качестве варианта ответа, этот параметр надо указывать True - тогда это позволить тексту начинаться от левого края кнопки. Если указать False, то текст будет строго по центру (например, Continue game)
///
struct HexagonalButton: View {
    let text: String
    let color: Color
    var width: CGFloat
    var height: CGFloat
    let action: () -> Void
    let isLeadingText: Bool
    @State var buttonWidth: Double = .zero
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Button {
                    action()
                } label: {
                    ZStack(alignment: isLeadingText ? .leading : .center) {
                        Hexagon()
                            .fill(color, strokeBorder: Color.white, lineWidth: 2)
                        
                        Text(text)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.5)
                            .lineLimit(3)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 2)
                            .padding(.leading, isLeadingText ? buttonWidth * 0.1 : 0)
                    }
                }
                .background(
                    GeometryReader(content: { geo in
                        Color.clear
                            .onAppear {
                                buttonWidth = geo.size.width
                            }
                    })
                )
            }
            .frame(width: width, height: height)
        }
    }
}


#Preview {
    HexagonalButton(
        text: "Game Start Game Start Game Start Game Start Game Start Game Start Game Start",
        color: .green,
        width: 250,
        height: 50,
        action: { print("Hello, world!") },
        isLeadingText: true
    )
}
