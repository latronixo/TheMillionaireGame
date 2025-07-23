//
//  PriceListView.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 22.07.2025.
//

import SwiftUI

struct PriceListView: View {
    
    let currentQuestion: Int //данные о текущем вопросе получим из вьюмодели или из постоянного хранилища - в зависимости от выбранной реализации
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 55/255, green: 76/255, blue: 148/255), Color(red: 16/255, green: 14/255, blue: 22/255)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { outerGeo in
                ZStack(alignment: .top) {
                    
                    VStack {
                        Spacer()
                            .frame(height: outerGeo.height * 0.15)
                        
                        GeometryReader { innerGeo in
                            
                            VStack(spacing: 0) {
                                let rowHeight = innerGeo.height / CGFloat(questionPrices.count)
                                
                                ForEach(questionPrices.reversed()) { question in
                                    QuestionPriceRow(
                                        item: question,
                                        height: rowHeight,
                                        width: innerGeo.width * 0.9,
                                        isCurrentQuestion: question.id == currentQuestion
                                    )
                                }
                            }
                        }
                    }
                    
                    
                    Image("logo")
                        .resizable()
                        .frame(
                            width: outerGeo.width * 0.5,
                            height: outerGeo.width * 0.55
                        )
                        .offset(y: -outerGeo.width * 0.06)
                }
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    PriceListView(currentQuestion: 7)
}

