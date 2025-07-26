//
//  CallView.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 26.07.2025.
//

import SwiftUI

struct CallView: View {
    
    @EnvironmentObject var viewModel: QuizViewModel
    @Binding var currentScreen: MainScreenDestination
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                BackgroundView()
                
                VStack {
                    
                    Spacer()
                    
                    VStack(spacing: geo.height * 0.10) {
                    Image("callFriend")
                        .resizable()
                        .scaledToFit()
                        .frame(height: geo.height * 0.4)
                    
                   
                        VStack(spacing: geo.height * 0.02) {
                            Text("I believe the correct answer is:")
                                .font(.title)
                                .foregroundStyle(Color.skyBlue)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                            
                            Text("\(viewModel.correctAnswer)")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .lineLimit(3)
                                .multilineTextAlignment(.center)
                                .textCase(.uppercase)
                        }
                }
                    .padding(.horizontal, geo.width * 0.08)
                    
                    Spacer()
                    
                    Button {
                        currentScreen = .game
                    } label: {
                        Text("Back to game")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.yellow)
                    }
                }
            }
        }
    }
}

#Preview {
    CallView(currentScreen: .constant(.call))
        .environmentObject(QuizViewModel())
}
