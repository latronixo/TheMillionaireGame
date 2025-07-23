//
//  RulesView.swift
//  TheMillionaireGame
//
//  Created by Chingiz on 23.07.2025.
//

import SwiftUI

struct RulesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    private let backgroundColor = Color(red: 0.192, green: 0.204, blue: 0.271)
    private let closeButtonColor = Color(red: 0.275, green: 0.655, blue: 0.929)
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("""
                        GAME RULES: WHO WANTS TO BE A MILLIONAIRE?

                        OBJECTIVE:
                        Answer 15 increasingly difficult questions to win $1,000,000. Questions are divided into three levels:
                        • Easy (1-5)
                        • Medium (6-10)
                        • Hard (11-15)

                        QUESTION VALUES:
                        1. $500            6. $7,500        11. $50,000
                        2. $1,000         7. $10,000      12. $100,000
                        3. $2,000        8. $12,500      13. $250,000
                        4. $3,000        9. $15,000      14. $500,000
                        5. $5,000       10. $25,000     15. $1,000,000

                        SAFE HAVENS (Guaranteed Sums):
                        • $1,000 (after Q5)
                        • $25,000 (after Q10)
                        • $1,000,000 (grand prize)

                        GAMEPLAY:
                        1. 30-second timer per question
                        2. Select one of four answer options
                        3. After selecting:
                           - Correct: Proceed to next question
                           - Incorrect: Game ends, you win last safe haven or $0
                        4. Time expiration ends game

                        LIFELINES (One-time use each):
                        1. 50:50: 
                           - Removes two incorrect answers
                           - Available from Q1

                        2. AUDIENCE HELP:
                           - Audience votes shown as percentages
                           - Correct answer probability: 70% (50% for hard questions)
                           - Visualized with a chart

                        3. PHONE A FRIEND:
                           - Friend suggests an answer
                           - Correct answer probability: 80%
                           - 30-second consultation

                        KEY MECHANICS:
                        ✓ WALK AWAY BUTTON:
                           - Ends game at any time
                           - Awards current winnings
                           - Crucial before risky questions

                        ✓ TIMER:
                           - Countdown starts immediately
                           - Red warning during last 5 seconds

                        ✓ SOUND DESIGN:
                           - Background music during thinking time
                           - Special cues for:
                             • Correct answers
                             • Winning the million
                             • Game over

                        WINNING CONDITIONS:
                        ✅ $1,000,000 WIN: Correct answers to all 15 questions
                        ❌ GAME OVER:
                           - Wrong answer
                           - Time expiration
                           - Voluntary walk-away
                           - You win last achieved safe haven

                        GOOD LUCK ON YOUR ROAD TO $1,000,000!
                        """)
                        .font(.system(size: 16))
                        .padding(.top, 32)
                        .padding(.bottom, 32)
                    }
                    .padding(.horizontal, 32)
                    .foregroundColor(.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Close")
                            .foregroundColor(closeButtonColor)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Rules")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .background(backgroundColor)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.white)
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    RulesView()
}
