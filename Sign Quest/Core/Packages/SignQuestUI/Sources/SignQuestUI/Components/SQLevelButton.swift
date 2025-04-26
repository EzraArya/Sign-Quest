//
//  SQLevelButton.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI

public enum SQLevelButtonStyle {
    case `default`
    case completed
    case locked
    
    var textColor: SQColor {
        switch self {
        case .default, .locked:
            return .text
        case .completed:
            return .primary
        }
    }
    
    var backgroundColor: SQColor {
        switch self {
        case .default:
            return .primary
        case .completed:
            return .complementary
        case .locked:
            return .muted
        }
    }
    
    var popupStyle: SQChatBubblePopupStyle {
        switch self {
        case .default:
            return .default
        case .completed:
            return .completed
        case .locked:
            return .inactive
        }
    }
    
    var popupSubtitle: String {
        switch self {
        case .default:
            return "Complete this level to earn rewards"
        case .completed:
            return "You have completed this level"
        case .locked:
            return "This level is locked"
        }
    }
    
    var popupButtonTitle: String {
        switch self {
        case .default:
            return "Start"
        case .completed:
            return "Completed"
        case .locked:
            return "Locked"
        }
    }
}

public struct SQLevelButton: View {
    var level: String
    var style: SQLevelButtonStyle
    var title: String
    var subtitle: String
    var action: (() -> Void)?

    @State private var showPopup = false

    public init(
        level: String,
        style: SQLevelButtonStyle = .default,
        title: String = "Level",
        subtitle: String = "Complete this level",
        buttonTitle: String = "Start",
        action: (() -> Void)? = nil
    ) {
        self.level = level
        self.style = style
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }

    public var body: some View {
        ZStack(alignment: .center) {
            Button {
                withAnimation(.spring()) {
                    showPopup.toggle()
                }
            } label: {
                SQText(text: level, font: .bold, color: style.textColor, size: 18)
                    .frame(width: 50, height: 50)
                    .background(style.backgroundColor.color)
                    .clipShape(Circle())
                    .shadow(color: SQColor.accent.color.opacity(0.3), radius: 0, x: 0, y: 4)
            }
            
            if showPopup {
                SQChatBubblePopup(
                    title: title,
                    subtitle: effectiveSubtitle,
                    buttonTitle: style.popupButtonTitle,
                    style: style.popupStyle,
                    buttonAction: {
                        withAnimation(.spring()) {
                            showPopup = false
                        }
                        action?()
                    }
                )
                .frame(width: 240)
                .offset(x: 175)
                .transition(.scale.combined(with: .opacity))
                .zIndex(1)
            }
        }
        .frame(width: 50, height: 50)
    }
}

extension SQLevelButton {
    private var effectiveSubtitle: String {
        if style == .default {
            return subtitle
        } else {
            return style.popupSubtitle
        }
    }
}
