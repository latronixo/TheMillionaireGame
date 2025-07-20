//
//  HeaderView.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(alignment: .center){
            Button {
                // dismiss
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
                // ???
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
    HeaderView()
}
