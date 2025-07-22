//
//  QuestionAndAnswerView.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct QuestionAndAnswerView: View {
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 70){
            
            //MARK: - Question
            
            Text("What year was the year, when first deodorant was invented in our life?")
                .foregroundStyle(.white)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .lineLimit(4)
                .padding(.horizontal)
            
            //MARK: - Buttons
            
            VStack(alignment: .leading, spacing: 70){
//                ForEach(, <#_#>, id: \.self) { section in
//                    Button {
//                        //Add Action
//                    } label: {
//                        
//                    }
//                }
                
            }
        }
        
    }
}
#Preview{
    QuestionAndAnswerView()
        .preferredColorScheme(.dark)
}
