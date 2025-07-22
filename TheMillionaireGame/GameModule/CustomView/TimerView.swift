//
//  Timer.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var vm: GameViewModel
    
    let totalTime: Double = 30
    @State private var timeRemaining: Double = 30
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isActive: Bool = true
    
    var body: some View {
        HStack(spacing: 5){
            Image(systemName: "clock.circle")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundStyle(.white)
            
            Text("\(Int(timeRemaining))")
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .fontWeight(.medium)
                .contentTransition(.numericText())
                .scaleEffect(timeRemaining <= 5 ? 1.2 : 1.0)
                .animation(timeRemaining <= 5 ? .spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5).repeatCount(1, autoreverses: true) : .default, value: timeRemaining)
        }
        .background {
            Capsule()
                .fill()
                .foregroundStyle(vm.setBackground(time: timeRemaining, totalTime: totalTime))
                .frame(width: 80, height: 45)
        }
        .onReceive(timer){_ in
            guard isActive else {return}
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                
                if timeRemaining <= 5 {
                    
                }
            } else {
                isActive = false
                timer.upstream.connect().cancel()
            }
            
            
        }
    }
}
#Preview {
    TimerView()
        .preferredColorScheme(.dark)
        .environmentObject(GameViewModel())
}
