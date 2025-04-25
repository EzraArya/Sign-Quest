//
//  SQChatBubblePopover.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI

public enum SQChatBubblePopupStyle {
    case `default`
    case inactive
    case completed
    
    var textColor: SQColor {
        switch self {
        case .default:
            return .primary
        case .inactive:
            return .accent
        case .completed:
            return .text
        }
    }
    
    var backgroundColor: SQColor {
        switch self {
        case .default:
            return .secondary
        case .inactive:
            return .background
        case .completed:
            return .primary
        }
    }
    
    var buttonStyle: SQButtonStyle {
        switch self {
        case .default:
            return .default
        case .inactive:
            return .locked
        case .completed:
            return .secondary
        }
    }
    
    var outlineColor: SQColor {
        switch self {
        case .default, .inactive, .completed:
            return .accent
        }
    }
}

public struct SQChatBubblePopup: View {
    var title: String
    var subtitle: String
    var buttonTitle: String
    var style: SQChatBubblePopupStyle
    var buttonAction: () -> Void
    
    public init(title: String, subtitle: String, buttonTitle: String, style: SQChatBubblePopupStyle = .default, buttonAction: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        self.style = style
        self.buttonAction = buttonAction
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            VStack(alignment: .leading, spacing: 4) {
                SQText(text: title, font: .bold, color: style.textColor, size: 14)
                SQText(text: subtitle, font: .regular, color: style.textColor, size: 12)
            }
            SQButton(text: buttonTitle, font: .bold, style: style.buttonStyle, size: 14, action: buttonAction)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            SQChatBubbleShape()
                .fill(style.backgroundColor.color)
                .overlay(
                    SQChatBubbleShape(outlineWidth: 2)
                        .outline(width: 2, color: style.outlineColor.color)
                )
        )
        .frame(maxWidth: 260)
    }
}
