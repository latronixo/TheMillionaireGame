//
//  Timer.swift
//  TheMillionaireGame
//
//  Created by Drolllted on 20.07.2025.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var vm: QuizViewModel
    
    let totalTime: Double = 30
    @State private var timeRemaining: Double = 30
    @State private var timer: Timer? = nil
    @State private var isActive: Bool = false
    
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
        
        .onReceive(vm.$shouldResetTimer, perform: { shouldReset in
            if shouldReset {
                stopTimer()
                vm.shouldResetTimer = false
            }
        })
        
        .onReceive(vm.$shouldStopTimer, perform: { shouldStop in
            if shouldStop {
                stopTimer()
                vm.shouldStopTimer = false
            }
        })
        
        .onAppear {
            startTimer()
            
        }
        
        .onDisappear {
            stopTimer()
        }
        
    }
    
    //MARK: - Methods
    
    private func startTimer() {
            // Останавливаем предыдущий таймер, если был
            stopTimer()
            
            // Устанавливаем начальное время
            timeRemaining = totalTime
            
            // Запускаем новый таймер
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stopTimer()
                    self.vm.timeExpired()
                }
            }
        }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func resetTimer() {
        stopTimer()
        startTimer()
    }
}

#Preview {
    TimerView()
        .preferredColorScheme(.dark)
        .environmentObject(QuizViewModel())
}
