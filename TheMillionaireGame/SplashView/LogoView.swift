//
//  LogoView.swift
//  TheMillionaireGame
//
//  Created by Chingiz on 22.07.2025.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        GeometryReader { geometry in
            Image("logo")
                .resizable()
                .frame(width: 267, height: 267)
                .shadow(color: Color.black.opacity(1.0), radius: 67)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
        }
    }
}

#Preview {
    LogoView()
}
