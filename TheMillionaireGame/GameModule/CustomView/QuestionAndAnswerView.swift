//
//  QuestionAndAnswerView.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct QuestionAndAnswerView: View {
    var body: some View {
        VStack(spacing: 70){
            
            //MARK: - Question
            
            Text("What year was the year, when first deodorant was invented in our life?")
                .foregroundStyle(.white)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .lineLimit(4)
            
            //MARK: - Buttons
            
            VStack(alignment: .leading, spacing: 70){
                ForEach(0...3, id: \.self) { section in
                    Button {
                        //Add Action
                    } label: {
                        Text("Button \(section.description)")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
                
            }
        }
        
    }
}
#Preview{
    QuestionAndAnswerView()
        .preferredColorScheme(.dark)
}
