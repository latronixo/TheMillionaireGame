//
//  Timer.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        HStack(spacing: 5){
            Image(systemName: "clock.circle")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundStyle(.white)
            
            Text("24")
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .fontWeight(.medium)
        }
        .background {
            Capsule()
                .fill()
                .foregroundStyle(.white.opacity(0.3))
                .frame(width: 80, height: 45)
        }
    }
}
#Preview {
    TimerView()
        
}
