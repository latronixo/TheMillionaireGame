//
//  HexagonalButton.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 21.07.2025.
//

import SwiftUI

struct HexagonalButton: View {
    let text: String
    let color: Color
    var width: CGFloat
    var height: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Button {
                    action()
                } label: {
                    ZStack {
                        Hexagon()
                            .fill(color)
                            .stroke(Color.white, lineWidth: 2)
                        
                        Text(text)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 2)
                    }
                }
            }
            .frame(width: width, height: height)
        }
    }
}


#Preview {
    HexagonalButton(
        text: "Game Start",
        color: Color.cyan,
        width: 250,
        height: 50,
        action: { print("Hello, world!") }
    )
}
