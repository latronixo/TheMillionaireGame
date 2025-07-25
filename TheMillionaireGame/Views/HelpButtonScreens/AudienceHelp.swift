//
//  AudienceHelp.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 25.07.2025.
//

import SwiftUI
import Charts

struct AudienceHelp: View {
    
    @State private var audienceRespond: [AudienceOpinion] = []
    @State private var isAnimated = false
    
    @EnvironmentObject var viewModel: QuizViewModel
    @Binding var currentScreen: MainScreenDestination
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                BackgroundView()
                
                VStack {
                    Spacer()
                        .frame(height: geo.height * 0.2)
                    
                    Chart {
                        ForEach(audienceRespond) { respond in
                            BarMark(
                                x: .value("Source", respond.source),
                                y: .value("Amount", isAnimated ? respond.count : 0),
                                width: .automatic
                            )
                            .foregroundStyle(Color.skyBlue.gradient)
                            .cornerRadius(5)
                            .annotation(
                                position: .top,
                                alignment: .center,
                                spacing: 10) {
                                    Text("\(respond.source)")
                                        .font(.title)
                                        .bold()
                            }
                        }
                    }
                    .padding()
                    .frame(height: geo.height * 0.4)
                    .chartYScale(domain: 0...300)
                    .chartXAxis {
//                    AxisMarks(values: .automatic) {
//                        AxisValueLabel()
//                            .font(.largeTitle)
//                    }
                    }
                    .chartYAxis {
//                        AxisMarks {
//                            AxisGridLine()
//                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        currentScreen = .game
                    } label: {
                        Text("Back to game")
                            .font(.headline)
                            .foregroundStyle(.yellow)
                    }
                }
            }
            .onAppear {
                print("onAppear AudienceHelp")
                audienceRespond = viewModel.generateAudienceHelpData(source: ["A", "B", "C", "D"])
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeInOut(duration: 2)) {
                           isAnimated = true
                       }
                   }
            }
            .onDisappear() {
                print("onDisappear AudienceHelp")
            }
        }
    }
}


#Preview {
    AudienceHelp(currentScreen: .constant(.audienceHelp))
        .environmentObject(QuizViewModel())
}
