//
//  SplashView.swift
//  TheMillionaireGame
//
//  Created by Chingiz on 21.07.2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            LogoView()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
