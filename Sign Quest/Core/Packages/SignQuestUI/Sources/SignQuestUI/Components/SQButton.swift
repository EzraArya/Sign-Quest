//
//  SQButton.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 21/04/25.
//

import SwiftUI

public enum SQButtonStyle {
    case `default`
    case secondary
    case muted
    case danger
    case incorrect
    case locked
    
    var textColor: SQColor {
        switch self {
        case .default:
            return .text
        case .secondary:
            return .primary
        case .muted:
            return .secondary
        case .danger:
            return .error
        case .incorrect:
            return .muted
        case .locked:
            return .accent
        }
    }
    
    var backgroundColor: SQColor {
        switch self {
        case .default:
            return .primary
        case .secondary:
            return .secondary
        case .muted:
            return .muted
        case .danger:
            return .background
        case .incorrect:
            return .error
        case .locked:
            return .muted
        }
    }
    
    var borderColor: SQColor {
        switch self {
        case .default:
            return .defaultBorder
        case .secondary:
            return .primary
        case .muted:
            return .secondary
        case .danger:
            return .error
        case .incorrect:
            return .muted
        case .locked:
            return .accent
        }
    }
}

public struct SQButton: View {
    public var text: String
    public var font: SQFont
    public var size: CGFloat
    public var style: SQButtonStyle
    public var action: () -> Void
    
    public init(text: String, font: SQFont, style: SQButtonStyle, size: CGFloat, action: @escaping () -> Void) {
        self.text = text
        self.font = font
        self.style = style
        self.size = size
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(text)
                .font(font.font(size: size))
                .foregroundColor(style.textColor.color)
                .padding()
                .frame(maxWidth: .infinity) // Makes the button fill the width
                .background(style.backgroundColor.color)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(style.borderColor.color, lineWidth: 1)
                )
                .shadow(
                    color: Color.black.opacity(0.3),
                    radius: 4,
                    x: 0,
                    y: 2
                )
        }
    }
}


