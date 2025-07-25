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
        GeometryReader { geo in
            VStack {
                Spacer()
                    .frame(height: geo.height * 0.25)
                
                
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
//                    AxisMarks {
//                            AxisGridLine()
//                        }
                }
                
                Spacer()
                
                Button("К игре") {
                    currentScreen = .game
                }
            }
        }
        .onAppear {
            print("onAppear AudienceHelp")
            audienceRespond = viewModel.generateAudienceHelpData(source: viewModel.ABCD)
            withAnimation(.easeInOut(duration: 3)) {
                isAnimated = true
            }
        }
        .onDisappear() {
            print("onDisappear AudienceHelp")
        }
    }
}

#Preview {
    AudienceHelp(currentScreen: .constant(.audienceHelp))
        .environmentObject(QuizViewModel())
}
