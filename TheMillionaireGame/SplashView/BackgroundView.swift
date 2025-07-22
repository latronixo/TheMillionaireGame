//
//  BackgroundView.swift
//  TheMillionaireGame
//
//  Created by Chingiz on 22.07.2025.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.215, green: 0.298, blue: 0.580),
                        Color(red: 0.063, green: 0.055, blue: 0.086)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                let topSpotSize: CGFloat = 321
                let bottomSpotSize: CGFloat = 179
                let blurRadius: CGFloat = 87
                let spotColor = Color(red: 0.145, green: 0.694, blue: 1.0)
                
                let center = CGPoint(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
                
                Circle()
                    .fill(spotColor.opacity(0.8))
                    .frame(width: topSpotSize, height: topSpotSize)
                    .blur(radius: blurRadius)
                    .position(
                        x: center.x - 120,
                        y: center.y - 172
                    )
                
                Circle()
                    .fill(spotColor)
                    .frame(width: bottomSpotSize, height: bottomSpotSize)
                    .blur(radius: blurRadius)
                    .position(
                        x: center.x + 150,
                        y: center.y + 143
                    )
            }
        }
    }
}

#Preview {
    BackgroundView()
}
