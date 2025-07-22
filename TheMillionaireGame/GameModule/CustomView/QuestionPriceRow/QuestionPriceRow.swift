//
//  QuestionPriceRow.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 22.07.2025.
//

import SwiftUI

struct QuestionPriceRow: View {
    var item: QuestionPrice
    var height: CGFloat
    var width: CGFloat
    var isCurrentQuestion: Bool
    
    private var hexagonColor: Color {
        if isCurrentQuestion {
            return .grassGreen
        }
        
        switch item.id {
        case 5, 10:
            return .skyBlue
        case 15:
            return .gold
        default:
            return .navy
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Hexagon()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [hexagonColor, hexagonColor.opacity(0.3)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: width, height: height)
                
                HStack {
                    Text("\(item.id):")
                    
                    Spacer()
                    
                    Text("\(item.currency.amount, format: .currency(code: item.currency.code).precision(.fractionLength(0)))")
                }
                .padding(.horizontal, width * 0.15)
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    QuestionPriceRow(
        item: questionPrices[5],
        height: 50,
        width: 370,
        isCurrentQuestion: true
    )
}
