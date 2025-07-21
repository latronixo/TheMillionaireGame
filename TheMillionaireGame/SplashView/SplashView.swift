//
//  SplashView.swift
//  TheMillionaireGame
//
//  Created by Chingiz on 21.07.2025.
//

import SwiftUI

struct SplashView: View {
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
                
                let logoWidth: CGFloat = 267
                let logoHeight: CGFloat = 267
                
                let centerX = geometry.size.width / 2
                let centerY = geometry.size.height / 2
                
                let logoTop = centerY - logoHeight / 2
                let logoLeft = centerX - logoWidth / 2
                let logoBottom = centerY + logoHeight / 2
                let logoRight = centerX + logoWidth / 2
                
                Circle()
                    .fill(Color(red: 0.145, green: 0.694, blue: 1.0).opacity(0.8))
                    .frame(width: 321, height: 321)
                    .blur(radius: 87)
                    .position(
                        x: logoLeft - 147 + 321 / 2,
                        y: logoTop - 199 + 321 / 2
                    )
                
                Circle()
                    .fill(Color(red: 0.145, green: 0.694, blue: 1.0))
                    .frame(width: 179, height: 179)
                    .blur(radius: 87)
                    .position(
                        x: logoRight + 106 - 179 / 2,
                        y: logoBottom + 99 - 179 / 2
                    )
                
                Image("logo")
                    .resizable()
                    .frame(width: logoWidth, height: logoHeight)
                    .shadow(color: Color.black.opacity(1.0), radius: 67)
                    .position(x: centerX, y: centerY)
            }
        }
    }
}

#Preview {
    SplashView()
}
