//
//  SQChatBubbleShape.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI

struct SQChatBubbleShape: Shape {
    var outlineWidth: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let adjustedRect = rect.insetBy(dx: outlineWidth/2, dy: outlineWidth/2)
        
        let path = Path { p in
            let cornerRadius: CGFloat = 6
            let tailWidth: CGFloat = 20
            let tailHeight: CGFloat = 30
            
            // Top left corner
            p.move(to: CGPoint(x: adjustedRect.minX + cornerRadius, y: adjustedRect.minY))
            
            // Top edge to top right corner
            p.addLine(to: CGPoint(x: adjustedRect.maxX - cornerRadius, y: adjustedRect.minY))
            p.addArc(center: CGPoint(x: adjustedRect.maxX - cornerRadius, y: adjustedRect.minY + cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: -90),
                     endAngle: Angle(degrees: 0),
                     clockwise: false)
            
            // Right edge to bottom right corner
            p.addLine(to: CGPoint(x: adjustedRect.maxX, y: adjustedRect.maxY - cornerRadius))
            p.addArc(center: CGPoint(x: adjustedRect.maxX - cornerRadius, y: adjustedRect.maxY - cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: 0),
                     endAngle: Angle(degrees: 90),
                     clockwise: false)
            
            // Bottom edge to bottom left corner
            p.addLine(to: CGPoint(x: adjustedRect.minX + cornerRadius, y: adjustedRect.maxY))
            p.addArc(center: CGPoint(x: adjustedRect.minX + cornerRadius, y: adjustedRect.maxY - cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: 90),
                     endAngle: Angle(degrees: 180),
                     clockwise: false)
            
            // Position the tail in the middle of the left side
            let tailY = adjustedRect.minY + adjustedRect.height * 0.5
            
            // Left edge to tail start
            p.addLine(to: CGPoint(x: adjustedRect.minX, y: tailY + tailHeight/2))
            
            // More curved, triangular tail using proper curve method
            p.addCurve(
                to: CGPoint(x: adjustedRect.minX - tailWidth, y: tailY),
                control1: CGPoint(x: adjustedRect.minX - tailWidth/4, y: tailY + tailHeight/2),
                control2: CGPoint(x: adjustedRect.minX - tailWidth*0.7, y: tailY + tailHeight/4)
            )
            p.addCurve(
                to: CGPoint(x: adjustedRect.minX, y: tailY - tailHeight/2),
                control1: CGPoint(x: adjustedRect.minX - tailWidth*0.7, y: tailY - tailHeight/4),
                control2: CGPoint(x: adjustedRect.minX - tailWidth/4, y: tailY - tailHeight/2)
            )
            
            // Left edge from tail to top left corner
            p.addLine(to: CGPoint(x: adjustedRect.minX, y: adjustedRect.minY + cornerRadius))
            p.addArc(center: CGPoint(x: adjustedRect.minX + cornerRadius, y: adjustedRect.minY + cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: 180),
                     endAngle: Angle(degrees: 270),
                     clockwise: false)
            
            p.closeSubpath()
        }
        return path
    }
    
    var inset: CGFloat {
        return outlineWidth / 2
    }
    
    func strokeBorderPath(in rect: CGRect) -> Path {
        return path(in: rect)
    }
}

extension SQChatBubbleShape {
    func outline(width: CGFloat, color: Color) -> some View {
        self
            .stroke(color, lineWidth: width)
    }
}
