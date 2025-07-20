//
//  Hexagon.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 21.07.2025.
//

import SwiftUI

struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let cornerOffset = width * 0.08
       
        let midLeft = CGPoint(x: 0, y: height / 2)
        let topLeft = CGPoint(x: cornerOffset, y: 0)
        let topRight = CGPoint(x: width - cornerOffset, y: 0)
        let midRight = CGPoint(x: width, y: height / 2)
        let bottomRight = CGPoint(x: width - cornerOffset, y: height)
        let bottomLeft = CGPoint(x: 0 + cornerOffset, y: height)
        
       
        path.move(to: midLeft)
        path.addLine(to: topLeft)
        path.addLine(to: topRight)
        path.addLine(to: midRight)
        path.addLine(to: bottomRight)
        path.addLine(to: bottomLeft)
        path.closeSubpath()
        
        return path
    }
}
