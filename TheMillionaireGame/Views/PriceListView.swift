//
//  PriceListView.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 22.07.2025.
//

import SwiftUI

struct PriceListView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @Binding var currentScreen: MainScreenDestination
    @StateObject private var soundManager = SoundManager.shared
    
    let currentQuestion: Int //данные о текущем вопросе получим из вьюмодели или из постоянного хранилища - в зависимости от выбранной реализации
    
    @ViewBuilder
    private func priceRows(rowHeight: CGFloat, width: CGFloat) -> some View {
        ForEach(questionPrices.reversed()) { question in
            QuestionPriceRow(
                item: question,
                height: rowHeight,
                width: width,
                isCurrentQuestion: question.id == (currentQuestion + 1)
            )
        }
    }
    
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
                            let rowHeight = innerGeo.height / CGFloat(questionPrices.count)
                            VStack(spacing: 0) {
                                priceRows(rowHeight: rowHeight, width: innerGeo.width * 0.9)
                            }
                        }
                        
                        Button {
                            currentScreen = .game
                            viewModel.priceOrHintScreenIsShown = true
                        } label: {
                            Text("Continue")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.yellow)
                        }
                    }
                    
                    
                    Image("logo")
                        .resizable()
                        .frame(
                            width: outerGeo.width * 0.3,
                            height: outerGeo.width * 0.28
                        )
                        .offset(y: outerGeo.width * 0.04)
                }
            }
        }
        .onDisappear {
            soundManager.stopSound("correctAnswer")
        }
    }
}

#Preview {
    PriceListView(currentScreen: .constant(.priceList), currentQuestion: 7)
        .environmentObject(QuizViewModel())
}

