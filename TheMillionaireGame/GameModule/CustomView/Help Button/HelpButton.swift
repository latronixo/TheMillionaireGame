//
//  HelpButton.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 21.07.2025.
//

import SwiftUI

enum HelpButtonType: String {
    case fiftyRemove = "fiftyRemove"
    case audience = "audience"
    case call = "call"
}

struct ReusableButton: View {

    var type: HelpButtonType
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Image(type.rawValue)
            }
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    ReusableButton(
        type: .fiftyRemove,
        width: 0,
        height: 0,
        action: {
        })
}
