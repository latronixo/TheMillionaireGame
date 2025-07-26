//
//  Timer.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var vm: QuizViewModel
    
    @State private var isActive: Bool = false
    
    var body: some View {
        HStack(spacing: 5){
            Image(systemName: "clock.circle")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundStyle(.white)
            
            Text("\(Int(vm.timeRemaining))")
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .fontWeight(.medium)
                .contentTransition(.numericText())
                .scaleEffect(vm.timeRemaining <= 5 ? 1.2 : 1.0)
                .animation(vm.timeRemaining <= 5 ? .spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5).repeatCount(1, autoreverses: true) : .default, value: vm.timeRemaining)
        }
        .background {
            Capsule()
                .fill()
                .foregroundStyle(vm.setBackground(time: Double(vm.timeRemaining), totalTime: Double(vm.totalTime)))
                .frame(width: 80, height: 45)
        }
        
        .onReceive(vm.$shouldResetTimer, perform: { shouldReset in
            if shouldReset {
                vm.stopTimer()
                vm.shouldResetTimer = false
            }
        })
        
        .onReceive(vm.$shouldStopTimer, perform: { shouldStop in
            if shouldStop {
                vm.stopTimer()
                vm.shouldStopTimer = false
            }
        })
        
        .onAppear {
            if vm.priceOrHintScreenIsShown {
                vm.priceOrHintScreenIsShown = false
                return
            }
        }
        
        .onDisappear {
            if vm.priceOrHintScreenIsShown { return }
            vm.stopTimer()
        }
        
    }
}

#Preview {
    TimerView()
        .preferredColorScheme(.dark)
        .environmentObject(QuizViewModel())
}
