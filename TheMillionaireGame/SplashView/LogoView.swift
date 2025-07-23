//
//  LogoView.swift
//  TheMillionaireGame
//
//  Created by Chingiz on 22.07.2025.
//

import SwiftUI

struct LogoView: View {
    var size: CGSize = CGSize(width: 267, height: 267)
    
    var body: some View {
        GeometryReader { geometry in
            Image("logo")
                .resizable()
                .frame(width: size.width, height: size.height)
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
