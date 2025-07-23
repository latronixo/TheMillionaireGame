//
//  InsettableShape + Ext.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 23.07.2025.
//

import SwiftUI

extension InsettableShape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: Double = 1) -> some View {
        self
            .strokeBorder(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}
