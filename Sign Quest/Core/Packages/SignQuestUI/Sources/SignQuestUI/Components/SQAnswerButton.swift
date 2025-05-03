//
//  SQAnswerButton.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 03/05/25.
//

import SwiftUI

public enum SQAnswerButtonStyle {
    case correct
    case incorrect
    case `default`
    case disabled
    
    var buttonStyle: SQButtonStyle {
        switch self {
        case .correct, .default:
            return .secondary
        case .incorrect:
            return .incorrect
        case .disabled:
            return .muted
        }
    }
    
    var textColor: SQColor {
        switch self {
        case .correct, .default, .disabled:
            return .secondary
        case .incorrect:
            return .error
        }
    }
    
    var backgroundColor: SQColor? {
        switch self {
        case .correct, .incorrect:
            return .muted
        case .default, .disabled:
            return nil
        }
    }
    
    var icon: String? {
        switch self {
        case .correct:
            return "checkmark.circle.fill"
        case .incorrect:
            return "xmark.circle.fill"
        case .default, .disabled:
            return nil
        }
    }

    var subText: String {
        switch self {
        case .correct:
            return "Correct"
        case .incorrect:
            return "Incorrect"
        case .default, .disabled:
            return ""
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .correct:
            return "Continue"
        case .incorrect:
            return "Got it"
        case .default, .disabled:
            return "Check"
        }
    }
    
    public static func determineStyle(
        isAnswered: Bool,
        isCorrect: Bool,
        isDisabled: Bool = false
    ) -> SQAnswerButtonStyle {
        if isDisabled {
            return .disabled
        }
        
        if isAnswered {
            return isCorrect ? .correct : .incorrect
        }
        
        return .default
    }
}

public struct SQAnswerButton: View {
    var style: SQAnswerButtonStyle
    var isCorrect: Bool
    var action: () -> Void
    
    @State private var animateScale: Bool = false
    @State private var animateOpacity: Bool = false
    
    public init(style: SQAnswerButtonStyle, isCorrect: Bool, action: @escaping () -> Void) {
        self.style = style
        self.isCorrect = isCorrect
        self.action = action
    }
    
    // Convenience initializer that uses the determineStyle function
    public init(
        isAnswered: Bool,
        isCorrect: Bool,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.style = SQAnswerButtonStyle.determineStyle(
            isAnswered: isAnswered,
            isCorrect: isCorrect,
            isDisabled: isDisabled
        )
        self.isCorrect = isCorrect
        self.action = action
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if let icon = style.icon {
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(style.textColor.color)
                        .scaleEffect(animateScale ? 1.2 : 1.0)
                }
                SQText(
                    text: style.subText,
                    font: .bold,
                    color: style.textColor,
                    size: 18
                )
            }
            HStack {
                SQButton(
                    text: style.buttonTitle,
                    font: .bold,
                    style: style.buttonStyle,
                    size: 16,
                    action: action
                )
            }
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(style.backgroundColor?.opacity(animateOpacity ? 1.0 : 0.7) ?? Color.clear)
        )
        .scaleEffect(animateScale ? 1.03 : 1.0)
        .animation(.spring(response: 0.3), value: animateScale)
        .animation(.easeInOut(duration: 0.4), value: animateOpacity)
        .onAppear {
            if style == .correct || style == .incorrect {
                withAnimation {
                    animateScale = true
                    animateOpacity = true
                }
                
                // Reset scale after animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        animateScale = false
                    }
                }
            }
        }
    }
}
