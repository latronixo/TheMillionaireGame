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
                currentScreen = .home
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
            }
            
            Spacer()
            
            VStack{
                Text("Question #1")
                
                Text("Price: 500$")
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
