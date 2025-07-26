//
//  HeaderView.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @Binding var currentScreen: MainScreenDestination
    
    var body: some View {
        HStack(alignment: .center){
            Button {
                viewModel.setTookMoneyPrize()
                currentScreen = .gameOver
            } label: {
                Image("getMoney")
                    .resizable()
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
            }
            
            Spacer()
            
            VStack{
                if viewModel.isLoading {
                    ProgressView("Loading questions...")
                } else {
                    Text("Question №\(viewModel.numberCurrentQuestion)")
                    let price = (viewModel.numberCurrentQuestion > 0 && viewModel.numberCurrentQuestion <= questionPrices.count) ? Int(questionPrices[viewModel.numberCurrentQuestion - 1].currency.amount) : 0
                    Text("Price: $\(price.formatted(.number.locale(Locale(identifier: "en_US"))))")
                }
            }
            .fontWeight(.medium)
            .font(.subheadline)
            .foregroundStyle(.white.opacity(0.7))
            .lineLimit(1)
            
            
            
            Spacer()
            
            Button {
                currentScreen = .priceList
            } label: {
                Image(systemName: "align.horizontal.right")
                    .resizable()
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
    }
}

#Preview {
    HeaderView(currentScreen: .constant(.game))
        .environmentObject(QuizViewModel())
}
