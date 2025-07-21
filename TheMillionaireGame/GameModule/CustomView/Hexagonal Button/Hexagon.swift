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
        let cornerOffset = width * 0.15
       
        let midLeft = CGPoint(x: 0, y: height / 2)
        let topLeft = CGPoint(x: cornerOffset, y: 0)
        
        let topRight = CGPoint(x: width - cornerOffset, y: 0)
        let midRight = CGPoint(x: width, y: height / 2)
        let bottomRight = CGPoint(x: width - cornerOffset, y: height)
        let bottomLeft = CGPoint(x: 0 + cornerOffset, y: height)
        
       
        path.move(to: midLeft)
        
        path.addCurve(
            to: topLeft,
            control1: CGPoint(x: cornerOffset / 2, y: 0),
            control2: CGPoint(x: cornerOffset / 2, y: 0)
        )
        
        path.addLine(to: topRight)
        
        path.addCurve(
            to: midRight,
            control1: CGPoint(x: width - (cornerOffset / 2), y: 0),
            control2: CGPoint(x: width - (cornerOffset / 2), y: 0)
        )
        
        path.addCurve(
            to: bottomRight,
            control1: CGPoint(x: width - (cornerOffset / 2), y: height),
            control2: CGPoint(x: width - (cornerOffset / 2), y: height)
        )
        
        path.addLine(to: bottomLeft)
        
        path.addCurve(
            to: midLeft,
            control1: CGPoint(x: cornerOffset / 2, y: height),
            control2: CGPoint(x: cornerOffset / 2, y: height)
        )
        
        return path
    }
}
