//
//  GameView.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(red: 55/255, green: 76/255, blue: 148/255), Color(red: 16/255, green: 14/255, blue: 22/255)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 40){
                HeaderView()
                TimerView()
                VStack(spacing: 60){
                    QuestionAndAnswerView()
                }
                Spacer()
            }
        }
    }
}

#Preview{
    GameView()
}
