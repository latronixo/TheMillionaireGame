//
//  QuestionPricesView.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 22.07.2025.
//

import SwiftUI

struct QuestionPricesView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 55/255, green: 76/255, blue: 148/255), Color(red: 16/255, green: 14/255, blue: 22/255)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geo in
                VStack(spacing: 0) {
                    let rowHeight = geo.height / CGFloat(questionPrices.count)
                    
                    ForEach(questionPrices.reversed()) { question in
                        QuestionPriceRow(
                            item: question,
                            height: rowHeight,
                            width: geo.width * 0.9
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    QuestionPricesView()
}

