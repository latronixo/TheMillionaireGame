//
//  QuestionPricesView.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 22.07.2025.
//

import SwiftUI

struct QuestionPricesView: View {
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ForEach(questionPrices.reversed()) { question in
                    QuestionPriceRow(
                        item: question,
                        height: geo.height / 18,
                        width: geo.width * 0.9
                    )
                }
            }
        }
    }
}

#Preview {
    QuestionPricesView()
}

//.frame(width: geo.width * 0.9, height: geo.height / 18)


// .padding(.horizontal, geo.width * 0.1)
